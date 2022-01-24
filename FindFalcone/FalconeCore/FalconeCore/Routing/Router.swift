//
//  Router.swift
//  FalconeCore
//
//  Created by Nguyen Ngoc Diep on 2022/01/23.
//

import Foundation
import Alamofire

enum Environment {
    case development
    case staging
    case production
}
public class Router {

    static var environment: Environment {
        #if DEV
        return .development
        #elseif STAGING
        return .staging
        #else
        return .production
        #endif
    }

    static private(set) var host: String = "https://findfalcone.herokuapp.com"

    static var baseUrl: String {
        switch environment {
        case .development:
            host = "https://findfalcone.herokuapp.com"
        case .staging:
            host = "https://findfalcone.herokuapp.com"
        case .production:
            host = "https://findfalcone.herokuapp.com"
        }
        return "\(host)"
    }

    public static func setHost(endpoint: String) {
        host = endpoint
    }

    func buildUrlRequest(_ route: Route) -> URLRequestConvertible {
        return RouterUrlConvertible(route: route)
    }

    func buildValidFullPathForRequest(_ path: String) -> String {
        if let url = URL(string: Router.baseUrl) {
            return url.appendingPathComponent(path).absoluteString
        }
        return path
    }
}
