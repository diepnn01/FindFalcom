//
//  SearchFalconeSection.swift
//  FalconeCore
//
//  Created by Nguyen Ngoc Diep on 2022/01/25.
//

import Foundation

public enum SearchFalconeSection: Int, CaseIterable {
    case destination1
    case destination2
    case destination3
    case destination4

    public var title: String {
        switch self {
        case .destination1: return "Destination 1"
        case .destination2: return "Destination 2"
        case .destination3: return "Destination 3"
        case .destination4: return "Destination 4"
        }
    }
}

public struct SearchFalconeSectionModel {

    public var destination: SearchFalconeSection
    public var planet: Planet?
    public var vehicle: Vehicle?

    public init(_ destination: SearchFalconeSection) {
        self.destination = destination
    }
}
