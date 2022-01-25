//
//  RequestParameterObject.swift
//  CoreProject
//
//  Created by Diep Nguyen on 12/4/18.
//  Copyright © 2018 Diep Nguyen. All rights reserved.
//

import Foundation

public protocol RequestParameterObject {
    
    func toJsonParams() -> [String: Any]
}
