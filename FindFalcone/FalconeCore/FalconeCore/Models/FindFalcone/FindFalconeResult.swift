//
//  FindFalconeResult.swift
//  FalconeCore
//
//  Created by Nguyen Ngoc Diep on 2022/01/24.
//

import Foundation

public struct FindFalconeResult: CoreObject {
    public var status: String?
    public var planetName: String?

    public init(data: [AnyHashable : Any]?) {
        status = data?["status"] as? String
        planetName = data?["planet_name"] as? String
    }
}
