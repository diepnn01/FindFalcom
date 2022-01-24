//
//  Route.swift
//  FalconeCore
//
//  Created by Nguyen Ngoc Diep on 2022/01/23.
//

import Foundation
import Alamofire

final class Route {
    
    fileprivate(set) var method: HTTPMethod
    fileprivate(set) var path: String
    fileprivate(set) var queryParams: [String: Any]?
    fileprivate(set) var jsonParams: [String: Any]?
    
    public init(method: HTTPMethod,
                path: String,
                queryParams: [String: Any]? = nil,
                jsonParams: [String: Any]? = nil) {
        self.method = method
        self.path = path
        self.queryParams = queryParams
        self.jsonParams = jsonParams
    }
}
