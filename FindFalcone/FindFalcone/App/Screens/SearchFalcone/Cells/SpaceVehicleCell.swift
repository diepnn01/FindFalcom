//
//  SpaceVehicleCell.swift
//  FindFalcone
//
//  Created by Nguyen Ngoc Diep on 2022/01/23.
//

import UIKit
import FalconeCore

final class SpaceVehicleCell: UITableViewCell {

    @IBOutlet weak var imvCheckBox: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!

    static var nib: UINib {
        return UINib(nibName: self.className, bundle: nil)
    }

    var isSelectedVehicle: Bool = false {
        didSet {
            imvCheckBox.image = UIImage(named: isSelectedVehicle ? "radiobox-marked_30" : "radiobox-blank_30")?.withRenderingMode(.alwaysTemplate)
        }
    }

    var vehicle: Vehicle? {
        didSet {
            labelTitle.text = "\(vehicle?.name ?? "") (\(vehicle?.totalNo ?? 0))"
        }
    }

    var isDisable: Bool = false {
        didSet {
            imvCheckBox.tintColor = isDisable ? .gray : .black
            labelTitle.textColor = isDisable ? .gray : .black
        }
    }
}
