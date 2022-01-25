//
//  SearchFalcomView.swift
//  FindFalcom
//
//  Created by Nguyen Ngoc Diep on 2022/01/22.
//

import Foundation
import FalconeCore

protocol SearchFalconeView: AnyObject {

    func onPrepareDataCompleted()

    func onSearchFalconeCompeted(_ falcone: FindFalconeResult)

    func onError(_ errorMsg: String)
}
