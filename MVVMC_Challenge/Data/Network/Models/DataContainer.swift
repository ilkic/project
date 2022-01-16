//
//  DataContainer.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import Foundation


public struct DataContainer<T: Codable>: Codable {
    public var offset: Int?
    public var limit: Int?
    public var total: Int?
    public var count: Int?
    public var results: [T]?
}
