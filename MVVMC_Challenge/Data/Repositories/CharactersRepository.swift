//
//  CharactersRepository.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import Foundation
import RxSwift
import Moya

protocol CharactersRepository {
    func fetchCharacterList(limit: Int, offset: Int) -> Single<[Character]>
    func fetchComicsOfCharacter(characterId: Int, orderBy: String, startYear: Int, limit: Int) -> Single<[Comic]>
}

final class DefeaultCharactersRepository {
    private var provider: MoyaProvider<CharactersEndpoints>
    
    init(provider: MoyaProvider<CharactersEndpoints>) {
        self.provider = provider
    }
}

extension DefeaultCharactersRepository: CharactersRepository {
    func fetchCharacterList(limit: Int, offset: Int) -> Single<[Character]> {
        return provider.rx
            .request(.characters(limit: limit, offset: offset))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(DataWrapper<CharacterResponse>.self)
            .map { $0.data?.results?.map({ cr in
                return cr.toDomain()
            }) ?? []}
    }
    
    
    func fetchComicsOfCharacter(characterId: Int, orderBy: String, startYear: Int, limit: Int) -> Single<[Comic]> {
        return provider.rx
            .request(.characterComics(characterId: characterId, limit: limit, startYear: startYear, orderBy: orderBy))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(DataWrapper<ComicResponse>.self)
            .map { $0.data?.results?.map({ cr in
                return cr.toDomain()
            }) ?? [] }
    }
    
}

