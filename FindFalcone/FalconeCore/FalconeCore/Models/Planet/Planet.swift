//
//  Planet.swift
//  FalconeCore
//
//  Created by Nguyen Ngoc Diep on 2022/01/24.
//

import Foundation

public struct Planet: CoreObject {
    public var name: String?
    public var distance: Int = 0

    public init(data: [AnyHashable : Any]?) {
        name = data?["name"] as? String
        if let temp = data?["distance"] as? Int {
            distance = temp
        }
    }
}
