//
//  SearchFalcomPresenter.swift
//  FindFalcom
//
//  Created by Nguyen Ngoc Diep on 2022/01/22.
//

import Foundation

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

    func attachView(_ view: SearchFalconeView) {
        self.view = view
    }

    func numberOfSections() -> Int {
        return SearchFalconeSection.allCases.count
    }

    func numberOfRows(at section: Int) -> Int {
        return 4
    }

}
