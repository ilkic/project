//
//  CharacterDetailComicListItemViewModel.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import Foundation

struct CharacterDetailsComicListItemViewModel {
    var title: String
    var imageUrl: String
}

extension CharacterDetailsComicListItemViewModel {
    init(comic: Comic) {
        title = comic.title
        imageUrl = comic.imageUrl
    }
}
