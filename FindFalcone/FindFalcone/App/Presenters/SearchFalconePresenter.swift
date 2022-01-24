//
//  SearchFalcomPresenter.swift
//  FindFalcom
//
//  Created by Nguyen Ngoc Diep on 2022/01/22.
//

import Foundation
import FalconeCore

enum SearchFalconeSection: Int, CaseIterable {
    case destination1
    case destination2
    case destination3
    case destination4

    var title: String {
        switch self {
        case .destination1: return "Destination 1"
        case .destination2: return "Destination 2"
        case .destination3: return "Destination 3"
        case .destination4: return "Destination 4"
        }
    }
}

struct SearchFalconeSectionModel {
    var destination: SearchFalconeSection
    var planet: Planet?
    var vehicle: Vehicle?

    init(_ destination: SearchFalconeSection) {
        self.destination = destination
    }
}


class SearchFalconePresenter {

    weak var view: SearchFalconeView?
    private let service = GetUserTokenService()
    private let findFalconeService = FindFalconeService()

    var sections = [SearchFalconeSectionModel]()
    var planets = [Planet]()
    var vehicles = [Vehicle]()
    var token = ""
    init() {
        sections.append(SearchFalconeSectionModel(.destination1))
        sections.append(SearchFalconeSectionModel(.destination2))
        sections.append(SearchFalconeSectionModel(.destination3))
        sections.append(SearchFalconeSectionModel(.destination4))
    }

    func attachView(_ view: SearchFalconeView) {
        self.view = view
    }

    func getUserToken() {
        service.getUserToken().cloudResponse { [weak self] userSession in
            print("Token \(userSession.token)")
            self?.token = userSession.token!
        }.cloudError { status, code in
            //
        }.finally {
            //
        }
    }

    func prepareData() {

        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        self.findFalconeService.getPlanets().cloudResponse { [weak self] collection in
            self?.planets = collection.items
            dispatchGroup.leave()
        }.cloudError { status, code in
            print("ddd")
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        self.findFalconeService.getVehicles().cloudResponse { [weak self] collection in
            self?.vehicles = collection.items
            dispatchGroup.leave()
        }.cloudError { status, code in
            print("ddd")
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.view?.prepareDataCompleted()
        }
    }

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

    func findFalcone() {
        var findFalconeParams = FindFalconeParam()
        findFalconeParams.vehicles = sections.map({$0.vehicle}).compactMap({$0})
        findFalconeParams.planets = sections.map({$0.planet}).compactMap({$0})

        findFalconeService.find(token: token, param: findFalconeParams).cloudResponse { result in
            print("Success \(result)")
        }.cloudError { status, code in
            print("Error")
        }
    }

    func numberOfSections() -> Int {
        return sections.count
    }

    func numberOfRows(at section: Int) -> Int {
        guard sections[section].planet != nil else {
            return 0
        }
        return vehicles.count
    }

}
