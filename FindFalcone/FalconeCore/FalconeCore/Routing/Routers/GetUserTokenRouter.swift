//
//  GetUserTokenRouter.swift
//  FalconeCore
//
//  Created by Nguyen Ngoc Diep on 2022/01/24.
//

import Foundation
import Alamofire

class GetUserTokenRouter: Router {

    public func getUserToken() -> URLRequestConvertible {
        let path = buildValidFullPathForRequest("/token")
        return buildUrlRequest(Route(method: .post,
                                     path: path))
    }
}
