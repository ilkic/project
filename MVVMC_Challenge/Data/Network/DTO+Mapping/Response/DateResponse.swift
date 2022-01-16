//
//  DateResponse.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import Foundation
import SwiftUI

struct DateResponse: Codable {
    var type: String
    var date: Date?
    
    
    private enum CodingKeys: String, CodingKey {
        case type
        case date
    }
}

extension DateResponse {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        let dateString = try container.decode(String.self, forKey: .date)
        date = ISO8601DateFormatter.formatter.date(from: dateString)
    }
}
