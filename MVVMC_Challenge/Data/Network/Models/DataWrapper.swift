//
//  DataWrapper.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import Foundation


public struct DataWrapper<T: Codable>: Codable {
    public var data: DataContainer<T>?
    public var status: String?
    public var code: Int?
}
