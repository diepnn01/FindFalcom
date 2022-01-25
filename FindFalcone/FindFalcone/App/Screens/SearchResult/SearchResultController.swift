//
//  SearchResultController.swift
//  FindFalcom
//
//  Created by Nguyen Ngoc Diep on 2022/01/22.
//

import UIKit
import FalconeCore

final class SearchResultController: BaseViewController {

    @IBOutlet weak var lblResultMessage: UILabel!
    @IBOutlet weak var lblResultTimeTaken: UILabel!
    @IBOutlet weak var lblResultFalconeName: UILabel!
    @IBOutlet weak var btnStartAgain: UIButton!

    var onStartAgain: (() -> Void)?
    var result: FindFalconeResult?
    var timeTaken: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        lblResultMessage.text = "SearchResult.Message".localized
        lblResultFalconeName.text = "\("SearchResult.PlanetFound".localized): \(result?.planetName ?? "")"
        lblResultTimeTaken.text = "\("FindingFalcone.TimeTaken".localized): \(timeTaken)"
    }

    private func setupUI() {

        title = "Finding Falcone!"
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        btnStartAgain.backgroundColor = AppColor.COLOR_4991DC
        btnStartAgain.setTitle("SearchResult.StartAgain".localized, for: .normal)
        btnStartAgain.setTitleColor(.white, for: .normal)
        btnStartAgain.layer.cornerRadius = 10
        btnStartAgain.layer.maskedCorners = [.layerMaxXMaxYCorner,
                                         .layerMaxXMinYCorner,
                                         .layerMinXMaxYCorner,
                                         .layerMinXMinYCorner]
    }

    @IBAction private func actionStartAgain(_ sender: UIButton) {
        onStartAgain?()
        navigationController?.popViewController(animated: true)
    }
}
