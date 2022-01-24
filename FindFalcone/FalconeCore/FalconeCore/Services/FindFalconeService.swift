//
//  FindFalconeService.swift
//  FalconeCore
//
//  Created by Nguyen Ngoc Diep on 2022/01/24.
//

import Foundation
import Alamofire

public class FindFalconeService: Router {

    public override init() {}
    private let router = FindFalconeRouter()

    public func getPlanets() -> ServiceRequest<PlanetCollection> {
        let request = ServiceRequest<PlanetCollection>()
        AF.request(router.getPlanets()).responseData { response in
            request.handleResponseJSONArray(response: response)
        }
        return request
    }

    public func getVehicles() -> ServiceRequest<VehicleCollection> {
        let request = ServiceRequest<VehicleCollection>()
        AF.request(router.getVehicles()).responseData { response in
            request.handleResponseJSONArray(response: response)
        }
        return request
    }

    public func find(token: String, param: FindFalconeParam) -> ServiceRequest<FindFalconeResult> {
        let request = ServiceRequest<FindFalconeResult>()
        AF.request(router.find(token: token, param: param)).responseData { response in
            request.handleResponseJSON(response: response)
        }
        return request
    }
}
