//
//  CharacterListItemViewModel.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import Foundation

struct CharacterListItemViewModel {
    var id: Int
    var name: String
    var imageUrl: String
    
    var character: Character
}


extension CharacterListItemViewModel {
    init(character: Character) {
        self.character = character
        self.id = character.id
        self.name = character.name
        self.imageUrl = character.imageUrl
    }
}
