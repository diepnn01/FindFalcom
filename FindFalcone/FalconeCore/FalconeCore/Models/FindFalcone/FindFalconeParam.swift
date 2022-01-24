//
//  FindFalcone.swift
//  FalconeCore
//
//  Created by Nguyen Ngoc Diep on 2022/01/24.
//

import Foundation

public struct FindFalconeParam: RequestParameterObject {
    public init() {}
    public var planets = [Planet]()
    public var vehicles = [Vehicle]()
    public func toJsonParams() -> [String : Any] {
        var dicts = [String: Any]()
        dicts["planet_names"] = planets.map({ $0.name })
        dicts["vehicle_names"] = planets.map({ $0.name })
        return dicts
    }
}
