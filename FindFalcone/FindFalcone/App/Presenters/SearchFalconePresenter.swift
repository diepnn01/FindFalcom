//
//  SearchFalcomPresenter.swift
//  FindFalcom
//
//  Created by Nguyen Ngoc Diep on 2022/01/22.
//

import Foundation
import FalconeCore

final class SearchFalconePresenter {

    weak var view: SearchFalconeView?

    //MARK: - Private properties
    private let service = GetUserTokenService()
    private let findFalconeService = FindFalconeService()

    //MARK: - Public properties
    var sections = [SearchFalconeSectionModel]()
    var dataSources = [String: [SearchFalconeRowModel]]()

    var planets = [Planet]()
    var vehicles = [Vehicle]()
    var token = ""

    init() {
        sections.append(SearchFalconeSectionModel(.destination1))
        sections.append(SearchFalconeSectionModel(.destination2))
        sections.append(SearchFalconeSectionModel(.destination3))
        sections.append(SearchFalconeSectionModel(.destination4))
    }

    //MARK: - Public Methods
    func attachView(_ view: SearchFalconeView) {
        self.view = view
    }

    func getUserToken() {
        service.getUserToken().cloudResponse { [weak self] userSession in
            self?.token = userSession.token!
        }
    }

    func prepareData() {
        view?.onShowProgress()

        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        self.findFalconeService.getPlanets().cloudResponse { [weak self] collection in
            self?.planets = collection.items
        }.finally {
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        self.findFalconeService.getVehicles().cloudResponse { [weak self] collection in
            self?.vehicles = collection.items
        }.finally {
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.view?.onPrepareDataCompleted()
        }
    }

    // Get the list of planets that was not used yet
    func enablePlanets(at section: Int) -> [Planet] {
        let selectedPlanetNames = sections.map({ $0.planet?.name }).compactMap({$0})
        return planets.filter { planet in
            return !selectedPlanetNames.contains(planet.name ?? "")
        }
    }

    func enableButtonFindFalcone() -> Bool {
        let selectedVehicles = sections.map({$0.vehicle?.name}).compactMap({$0})
        return selectedVehicles.count == sections.count
    }

    func calculateTimeTaken() -> Int {
        var newTimeTaken = 0
        sections.forEach { sectionModel in
            if let distance = sectionModel.planet?.distance, let speed = sectionModel.vehicle?.speed {
                newTimeTaken += Int(distance / speed)
            }
        }
        return newTimeTaken
    }

    func updateVehicleStatusForEachPlanet(at section: Int) {
        let vehiclesForSection = vehicles.map { object -> SearchFalconeRowModel in
            var vehicleRow = SearchFalconeRowModel(object)

            let sectionModel = sections[section]
            let maxVehicleCanBeUsed = object.totalNo
            let totalVehicleWasUsed = sections.filter({$0.vehicle?.name == object.name}).count

            vehicleRow.isEnable = (object.maxDistance >= (sectionModel.planet?.distance ?? 0)) && (totalVehicleWasUsed < maxVehicleCanBeUsed)
            return vehicleRow
        }

        dataSources[sections[section].destination.title] = vehiclesForSection
    }

    func resetData() {
        for index in 0..<sections.count {
            sections[index].planet = nil
        }
        dataSources.removeAll()
    }

    func findFalcone() {
        var findFalconeParams = FindFalconeParam()
        findFalconeParams.vehicles = sections.map({$0.vehicle}).compactMap({$0})
        findFalconeParams.planets = sections.map({$0.planet}).compactMap({$0})

        findFalconeService.find(token: token, param: findFalconeParams)
            .cloudResponse { [weak self] result in
                self?.view?.onSearchFalconeCompeted(result)
            }.cloudError { [weak self] (status, code) in
                self?.view?.onError(status)
            }
    }
}


// MARK: - Prepare TablView datasource
extension SearchFalconePresenter {

    func numberOfSections() -> Int {
        return sections.count
    }

    func numberOfRows(at section: Int) -> Int {
        guard sections[section].planet != nil else {
            return 0
        }
        guard let items = dataSources[sections[section].destination.title] else {
            return 0
        }
        return items.count
    }

    func vehicle(at indexPath: IndexPath) -> SearchFalconeRowModel? {
        let sectionModel = sections[indexPath.section]
        guard let items = dataSources[sectionModel.destination.title] else {
            return nil
        }
        return items[indexPath.row]
    }
}
