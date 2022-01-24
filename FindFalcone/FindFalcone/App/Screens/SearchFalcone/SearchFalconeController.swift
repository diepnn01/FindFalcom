//
//  ViewController.swift
//  FindFalcom
//
//  Created by Nguyen Ngoc Diep on 2022/01/21.
//

import UIKit

final class SearchFalconeController: BaseViewController {

    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelGuide: UILabel!
    @IBOutlet weak var lblTakeTime: UILabel!
    @IBOutlet weak var btnSearch: UIButton!

    //MARK: Private properties
    private var presenter: SearchFalconePresenter!
    private var timeTaken: Int = 0 {
        didSet {
            lblTakeTime.text = "Time taken: \(timeTaken)"
        }
    }

    private var enableSearch: Bool = false {
        didSet {
            btnSearch.isEnabled = enableSearch
            btnSearch.backgroundColor = enableSearch ? UIColor("#4991DC") : .gray
        }
    }

    override func loadView() {
        super.loadView()
        presenter = SearchFalconePresenter()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        setupUI()
        presenter.prepareData()
        presenter.getUserToken()
    }

    //MARK: Private methods
    private func setupPresenter() {
        presenter.attachView(self)
    }

    private func setupUI() {
        timeTaken = 0
        title = "FindingFalcone.Title".localized
        labelGuide.text = "Select planets you want to search in:"

        btnSearch.setTitle("Find Falcone!", for: .normal)
        btnSearch.setTitleColor(.white, for: .normal)
        btnSearch.layer.cornerRadius = 10
        btnSearch.layer.maskedCorners = [.layerMaxXMaxYCorner,
                                         .layerMaxXMinYCorner,
                                         .layerMinXMaxYCorner,
                                         .layerMinXMinYCorner]
        enableSearch = false
        tableView.register(SpaceVehicleCell.nib, forCellReuseIdentifier: SpaceVehicleCell.className)
    }

    private func selectPlanet(at section: Int) {
        let planetsVC = UIStoryboard.loadController(from: "Main", of: SelectPlanetController.self)
        planetsVC.planets = presenter.enablePlanets(at: section)
        planetsVC.currentPlanet = presenter.sections[section].planet
        planetsVC.onSelectedPlanet = { [weak self] newPlanet in
            self?.presenter.sections[section].planet = newPlanet
            self?.tableView.reloadSections([section], with: .automatic)

        }
        navigationController?.pushViewController(planetsVC, animated: true)
    }

    @IBAction private func actionFindFalcone(_ sender: UIButton) {
        presenter.findFalcone()
    }
}

//MARK: - UITableViewDataSource
extension SearchFalconeController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows(at: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SpaceVehicleCell.className, for: indexPath) as? SpaceVehicleCell else {
            return UITableViewCell()
        }
        cell.title = presenter.vehicles[indexPath.row].name
        cell.isSelectedVehicle = presenter.vehicles[indexPath.row].name == self.presenter.sections[indexPath.section].vehicle?.name
        return cell
    }
}


//MARK: - UITableViewDelegate
extension SearchFalconeController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = UIView.loadFromNib(named: SearchFalconeSectionHeaderView.className) as? SearchFalconeSectionHeaderView else {
            return UIView()
        }
        let sectionModel = presenter.sections[section]
        headerView.title = sectionModel.destination.title
        headerView.planet = sectionModel.planet
        headerView.onSelectPlanet = { [weak self] in
            self?.selectPlanet(at: section)
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard self.presenter.sections[indexPath.section].vehicle?.name != presenter.vehicles[indexPath.row].name else {
            return
        }

        var indexPaths = [IndexPath]()
        for index in 0..<presenter.vehicles.count {
            indexPaths.append(IndexPath(row: index, section: indexPath.section))
        }

        // update selected vehicle
        self.presenter.sections[indexPath.section].vehicle = presenter.vehicles[indexPath.row]
        self.tableView.reloadRows(at: indexPaths, with: .automatic)
        
        // update search falcone button status
        self.enableSearch = self.presenter.enableButtonFindFalcone()

        // update time taken
        timeTaken = presenter.calculateTimeTaken()
    }
}

//MARK: - SearchFalcomView
extension SearchFalconeController: SearchFalconeView {

    func prepareDataCompleted() {
        tableView.reloadData()
    }
}

