//
//  String+Ext.swift
//  FindFalcom
//
//  Created by Nguyen Ngoc Diep on 2022/01/22.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }

    /// Load the localized string with additional arguments
    /// - Parameter arguments: The list arguments
    /// - Returns: The localized string with the arguments
    func localizedWithFormat(_ arguments: [CVarArg]) -> String {
        let localizedString = String(format: localized, arguments: arguments)
        return localizedString
    }
}
