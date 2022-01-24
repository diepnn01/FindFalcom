//
//  Vehicle.swift
//  FalconeCore
//
//  Created by Nguyen Ngoc Diep on 2022/01/24.
//

import Foundation

public struct Vehicle: CoreObject {

    public var name: String?
    public var totalNo: Int = 0
    public var maxDistance: Int = 0
    public var speed: Int = 0

    public init(data: [AnyHashable : Any]?) {
        name = data?["name"] as? String
        if let temp = data?["total_no"] as? Int {
            totalNo = temp
        }
        if let temp = data?["max_distance"] as? Int {
            maxDistance = temp
        }

        if let temp = data?["speed"] as? Int {
            speed = temp
        }
    }
}
