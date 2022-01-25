//
//  ViewController.swift
//  FindFalcom
//
//  Created by Nguyen Ngoc Diep on 2022/01/21.
//

import UIKit
import ProgressHUD
import FalconeCore

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
            lblTakeTime.text = "\("FindingFalcone.TimeTaken".localized): \(timeTaken)"
        }
    }

    private var enableSearch: Bool = false {
        didSet {
            btnSearch.isEnabled = enableSearch
            btnSearch.backgroundColor = enableSearch ? AppColor.COLOR_4991DC : .gray
        }
    }

    //MARK: Public methods
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
        labelGuide.text = "FindingFalcone.Guide".localized

        btnSearch.setTitle("FindingFalcone.BtnSearch.Title".localized, for: .normal)
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
            self?.presenter.sections[section].vehicle = nil
            self?.presenter.updateVehicleStatusForEachPlanet(at: section)
            self?.tableView.reloadSections([section], with: .automatic)
        }
        navigationController?.pushViewController(planetsVC, animated: true)
    }

    private func showProgressHUD() {
        ProgressHUD.animationType = .circleStrokeSpin
        ProgressHUD.colorHUD = AppColor.COLOR_4991DC
        ProgressHUD.show()
    }

    @IBAction private func actionFindFalcone(_ sender: UIButton) {
        showProgressHUD()
        presenter.findFalcone()
    }

    private func showMessage(_ message: String) {

        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
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
        guard let vehicleRow = presenter.vehicle(at: indexPath) else {
            return UITableViewCell()
        }
        let sectionModel = presenter.sections[indexPath.section]
        cell.vehicle = vehicleRow.vehicle
        cell.isDisable = !vehicleRow.isEnable
        cell.isSelectedVehicle = vehicleRow.vehicle.name == sectionModel.vehicle?.name
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard self.presenter.sections[indexPath.section].vehicle?.name != presenter.vehicles[indexPath.row].name else {
            return
        }

        guard let cell = tableView.cellForRow(at: indexPath) as? SpaceVehicleCell, !cell.isDisable else {
            return
        }

        // Reset selected vehicle
        var indexPaths = [IndexPath]()
        for index in 0..<presenter.vehicles.count {
            indexPaths.append(IndexPath(row: index, section: indexPath.section))
        }

        // update selected vehicle
        self.presenter.sections[indexPath.section].vehicle = presenter.vehicles[indexPath.row]
        self.tableView.reloadRows(at: indexPaths, with: .automatic)

        // update search falcone button status
        self.enableSearch = presenter.enableButtonFindFalcone()

        // update time taken
        timeTaken = presenter.calculateTimeTaken()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

//MARK: - SearchFalcomView
extension SearchFalconeController: SearchFalconeView {

    func onShowProgress() {
        showProgressHUD()
    }

    func onPrepareDataCompleted() {
        ProgressHUD.dismiss()
        tableView.reloadData()
    }

    func onSearchFalconeCompeted(_ falcone: FindFalconeResult) {
        ProgressHUD.dismiss()
        guard falcone.status == "success" else {
            if let error = falcone.error {
                showMessage(error)
            } else {
                showMessage("Oh Sorry, cannot find Falcone!")
            }
            return
        }
        let resultVC = UIStoryboard.loadController(from: "Main", of: SearchResultController.self)
        resultVC.result = falcone
        resultVC.timeTaken = timeTaken
        resultVC.onStartAgain = { [weak self] in
            //Reset allData
            self?.presenter.resetData()
            self?.tableView.reloadData()
        }
        navigationController?.pushViewController(resultVC, animated: true)
    }

    func onError(_ errorMsg: String) {
        //TODO: handle error here
        ProgressHUD.dismiss()
        showMessage(errorMsg)
    }
}

