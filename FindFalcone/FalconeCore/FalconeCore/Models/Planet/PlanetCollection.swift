//
//  PlanetCollection.swift
//  FalconeCore
//
//  Created by Nguyen Ngoc Diep on 2022/01/24.
//

import Foundation

public struct PlanetCollection: CoreObject {
    public var items = [Planet]()

    public init(data: [AnyHashable : Any]?) {
        if let objects = data?["items"] as? [[AnyHashable: Any]] {
            items = objects.map({ Planet(data: $0) })
        }
    }
}
