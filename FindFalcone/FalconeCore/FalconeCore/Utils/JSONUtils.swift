//
//  JSONUtils.swift
//  FalconeCore
//
//  Created by Nguyen Ngoc Diep on 2022/01/24.
//

import Foundation
class JSONUtils {
    enum JSONUtilsError: Error {
        case jsonIsNotDictionary
        case jsonIsNotValid
    }

    static func toDictionary(_ jsonString: String) throws -> NSDictionary {
        if let dictionary = try jsonToAnyObject(jsonString) as? NSDictionary {
            return dictionary
        } else {
            throw JSONUtilsError.jsonIsNotDictionary
        }
    }

    static func toJsonString(_ jsonObject: [String: Any]) throws -> String {
        let data = try JSONSerialization.data(withJSONObject: jsonObject)
        return String(data: data, encoding: .utf8)!
    }

    static private func jsonToAnyObject(_ jsonString: String) throws -> Any? {
        var any: Any?

        if let data = jsonString.data(using: String.Encoding.utf8) {
            do {
                any = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            } catch {
                throw JSONUtilsError.jsonIsNotValid
            }
        }
        return any
    }

    static func toDictionary(_ data: Data?) -> [AnyHashable: Any]? {
        guard let data = data else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable: Any]
    }

    static func toArrayDictionary(_ data: Data?) -> [[AnyHashable: Any]]? {
        guard let data = data else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [[AnyHashable: Any]]
    }
}
