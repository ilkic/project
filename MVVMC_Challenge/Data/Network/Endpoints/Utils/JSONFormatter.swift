//
//  JSONFormatter.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import Foundation

public func JSONRequestDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        guard let result = String(data: prettyData, encoding: String.Encoding.utf8) else {
            return String(decoding: data, as: UTF8.self)
        }
        return result
    } catch {
        return String(decoding: data, as: UTF8.self)
    }
}
