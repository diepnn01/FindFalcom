//
//  VehicleCollection.swift
//  FalconeCore
//
//  Created by Nguyen Ngoc Diep on 2022/01/24.
//

import Foundation

public struct VehicleCollection: CoreObject {
    public var items = [Vehicle]()

    public init(data: [AnyHashable : Any]?) {
        if let objects = data?["items"] as? [[AnyHashable: Any]] {
            items = objects.map({ Vehicle(data: $0) })
        }
    }
}
