//
//  SearchFalcomPresenter.swift
//  FindFalcom
//
//  Created by Nguyen Ngoc Diep on 2022/01/22.
//

import Foundation
import FalconeCore

enum SearchFalconeSection: Int, CaseIterable {
    case destination1
    case destination2
    case destination3
    case destination4

    var title: String {
        switch self {
        case .destination1: return "Destination 1"
        case .destination2: return "Destination 2"
        case .destination3: return "Destination 3"
        case .destination4: return "Destination 4"
        }
    }
}


class SearchFalconePresenter: SearchFalconeView {

    weak var view: SearchFalconeView?
    private let service = GetUserTokenService()
    private let planetService = GetPlanetsService()
    func attachView(_ view: SearchFalconeView) {
        self.view = view
    }

    func getUserToken() {
        service.getUserToken().cloudResponse { userSession in
            print("Token \(userSession.token)")
        }.cloudError { status, code in
            //
        }.finally {
            //
        }

        planetService.getPlanets().cloudResponse { planets in
            print("Here we go")
        }.cloudError { status, code in
            print("ddd")
        }
        planetService.getVehicles().cloudResponse { vehicles in
            print("Here we go")
        }.cloudError { status, code in
            print("ddd")
        }
    }

    func numberOfSections() -> Int {
        return SearchFalconeSection.allCases.count
    }

    func numberOfRows(at section: Int) -> Int {
        return 4
    }

}
