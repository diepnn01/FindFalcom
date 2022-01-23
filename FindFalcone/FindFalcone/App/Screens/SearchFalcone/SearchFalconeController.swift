//
//  ViewController.swift
//  FindFalcom
//
//  Created by Nguyen Ngoc Diep on 2022/01/21.
//

import UIKit

final class SearchFalconeController: BaseViewController {



    //MARK: Outlets
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

    override func loadView() {
        super.loadView()
        presenter = SearchFalconePresenter()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        setupUI()
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
        return UITableViewCell()
    }
}


//MARK: - UITableViewDelegate
extension SearchFalconeController: UITableViewDelegate {


}

//MARK: - SearchFalcomView
extension SearchFalconeController: SearchFalconeView {

}

