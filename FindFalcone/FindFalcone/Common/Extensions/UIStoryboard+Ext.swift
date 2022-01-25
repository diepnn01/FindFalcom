//
//  UIStoryboard+Ext.swift
//  FindFalcom
//
//  Created by Nguyen Ngoc Diep on 2022/01/22.
//

import Foundation
import UIKit

extension UIStoryboard {
    static func loadController<T>(from storyboard: String, of type: T.Type, with identifier: String? = nil) -> T {
        let storybroad = UIStoryboard(name: storyboard, bundle: Bundle.main)
        let identifier = identifier ?? String(describing: type.self)
        guard let vc = storybroad.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Cannot found viewcontroller with \(identifier)")
        }
        return vc
    }

    func instantiateViewController<T>(_ type: T.Type = T.self) -> T where T: UIViewController {
        guard let viewController = instantiateViewController(withIdentifier: type.className) as? T else {
            fatalError()
        }

        return viewController
    }
}
