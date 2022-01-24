//
//  SpaceVehicleCell.swift
//  FindFalcone
//
//  Created by Nguyen Ngoc Diep on 2022/01/23.
//

import UIKit

final class SpaceVehicleCell: UITableViewCell {

    @IBOutlet weak var imvCheckBox: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!

    static var nib: UINib {
        return UINib(nibName: self.className, bundle: nil)
    }

    var isSelectedVehicle: Bool = false {
        didSet {
            imvCheckBox.image = UIImage(named: isSelectedVehicle ? "radiobox-marked_30" : "radiobox-blank_30")
        }
    }

    var title: String? {
        didSet {
            labelTitle.text = title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
