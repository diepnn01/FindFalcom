//
//  UserSessionModel.swift
//  FalconeCore
//
//  Created by Nguyen Ngoc Diep on 2022/01/24.
//

import Foundation

public struct UserSession: CoreObject {

    public var token: String?

    public init(data: [AnyHashable : Any]?) {
        token = data?["token"] as? String
    }
}
