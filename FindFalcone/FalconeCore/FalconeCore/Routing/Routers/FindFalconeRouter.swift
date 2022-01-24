//
//  GetPlanetsRouter.swift
//  FalconeCore
//
//  Created by Nguyen Ngoc Diep on 2022/01/24.
//

import Foundation
import Alamofire

public class FindFalconeRouter: Router {
    
    public func getPlanets() -> URLRequestConvertible {
        let path = buildValidFullPathForRequest("/planets")
        return buildUrlRequest(Route(method: .get,
                                     path: path))
    }

    public func getVehicles() -> URLRequestConvertible {
        let path = buildValidFullPathForRequest("/vehicles")
        return buildUrlRequest(Route(method: .get,
                                     path: path))
    }

    public func find(token: String, param: FindFalconeParam) -> URLRequestConvertible {
        let path = buildValidFullPathForRequest("/find")
        var params = param.toJsonParams()
        params["token"] = token
        return buildUrlRequest(Route(method: .post,
                                     path: path,
                                     jsonParams: params))
    }
}
