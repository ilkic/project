//
//  FetchCharactersUseCase.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import Foundation
import RxSwift

protocol FetchCharacterListUseCase {
    func execute(request: FetchCharacterListUseCaseRequestValue) -> Single<[Character]>
}

final class DefaultFetchCharacterListUseCase {
    
    private var charactersRepository: CharactersRepository
    
    init(charactersRepository: CharactersRepository) {
        self.charactersRepository = charactersRepository
    }
}

extension DefaultFetchCharacterListUseCase: FetchCharacterListUseCase {
    func execute(request: FetchCharacterListUseCaseRequestValue) -> Single<[Character]> {
        return charactersRepository.fetchCharacterList(limit: request.limit, offset: request.offset)
    }
}

struct FetchCharacterListUseCaseRequestValue {
    var limit: Int = DefaultLimit
    var offset: Int
}
