//
//  ComicResponse.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import Foundation

struct ComicResponse: Codable {
    var id: Int
    var title: String
    var thumbnail: ImageResponse
}

extension ComicResponse {
    func toDomain() -> Comic {
        return Comic(id: id, title: title, imageUrl: thumbnail.path + "." + thumbnail.extension)
    }
}
