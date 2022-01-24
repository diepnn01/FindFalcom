//
//  GetUserToken.swift
//  FalconeCore
//
//  Created by Nguyen Ngoc Diep on 2022/01/24.
//

import Foundation
import Alamofire
public class GetUserTokenService {
    public init() {}
    private let router = GetUserTokenRouter()
    public func getUserToken() -> ServiceRequest<UserSession> {
        let request = ServiceRequest<UserSession>()

        AF.request(router.getUserToken())
            .validate()
            .responseData { response in
                request.handleResponseJSON(response: response)
            }
        return request
    }
}
