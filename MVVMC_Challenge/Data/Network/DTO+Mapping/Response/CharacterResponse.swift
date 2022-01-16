//
//  CharacterResponse.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import Foundation

struct CharacterResponse: Codable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: ImageResponse
    
}


extension CharacterResponse {
    func toDomain() -> Character {
        return Character(id: id, name: name, description: description, imageUrl: thumbnail.path + "." + thumbnail.extension)
    }
}
