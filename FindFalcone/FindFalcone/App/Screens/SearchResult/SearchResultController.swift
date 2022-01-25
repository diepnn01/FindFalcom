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

    var result: FindFalconeResult?
    var timeTaken: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        lblResultMessage.text = "Success!, Congratulations on Finding Falcone. King Shan is mighty pleased."
        lblResultFalconeName.text = "Planet found: \(result?.planetName ?? "")"
        lblResultTimeTaken.text = "Time Taken: \(timeTaken)"
    }

    private func setupUI() {
        btnStartAgain.backgroundColor = UIColor("#4991DC")
        btnStartAgain.setTitle("Start Again", for: .normal)
        btnStartAgain.setTitleColor(.white, for: .normal)
        btnStartAgain.layer.cornerRadius = 10
        btnStartAgain.layer.maskedCorners = [.layerMaxXMaxYCorner,
                                         .layerMaxXMinYCorner,
                                         .layerMinXMaxYCorner,
                                         .layerMinXMinYCorner]
    }

    @IBAction private func actionStartAgain(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
