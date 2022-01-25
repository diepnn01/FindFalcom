//
//  NSObject+Ext.swift
//  FindFalcom
//
//  Created by Nguyen Ngoc Diep on 2022/01/22.
//

import UIKit
import Foundation

extension NSObject {

    var className: String {

        return String(describing: type(of: self))
    }

    class var className: String {

        return String(describing: self)
    }
}
