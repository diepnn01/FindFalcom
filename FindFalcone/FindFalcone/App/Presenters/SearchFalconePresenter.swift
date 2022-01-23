//
//  SearchFalcomPresenter.swift
//  FindFalcom
//
//  Created by Nguyen Ngoc Diep on 2022/01/22.
//

import Foundation

class SearchFalconePresenter: SearchFalconeView {

    weak var view: SearchFalconeView?

    func attachView(_ view: SearchFalconeView) {
        self.view = view
    }

    func numberOfSections() -> Int {
        return 4
    }

    func numberOfRows(at section: Int) -> Int {
        return 4
    }

}
