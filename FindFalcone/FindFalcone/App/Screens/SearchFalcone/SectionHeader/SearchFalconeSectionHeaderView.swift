//
//  SearchFalconeSectionHeaderView.swift
//  FindFalcone
//
//  Created by Nguyen Ngoc Diep on 2022/01/23.
//

import UIKit

final class SearchFalconeSectionHeaderView: UIView {

    @IBOutlet weak var btnSelectPlanet: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!

    var onSelectPlanet: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        btnSelectPlanet.setTitle(nil, for: .normal)
    }

    var title: String? {
        didSet {
            labelTitle.text = title
        }
    }

    @IBAction private func actionSelectPlanet(_ sender: UIButton) {
        onSelectPlanet?()
    }
}
