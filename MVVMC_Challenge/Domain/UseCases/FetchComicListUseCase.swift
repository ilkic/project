//
//  FetchComicListUseCase.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import Foundation
import RxSwift

protocol FetchComicListUseCase {
    func execute(request: FetchComicListUseCaseRequestValue) -> Single<[Comic]>
}

final class DefaultFetchComicListUseCase {
    
    private var charactersRepository: CharactersRepository
    
    init(charactersRepository: CharactersRepository) {
        self.charactersRepository = charactersRepository
    }
}

extension DefaultFetchComicListUseCase: FetchComicListUseCase {
    func execute(request: FetchComicListUseCaseRequestValue) -> Single<[Comic]> {
        charactersRepository.fetchComicsOfCharacter(characterId: request.characterId,
                                                    orderBy: request.orderBy,
                                                    startYear: request.startYear,
                                                    limit: request.limit).map {$0.reversed()}
    }
}

struct FetchComicListUseCaseRequestValue {
    var orderBy = "onsaleDate"
    var startYear = 2005
    var limit = 10
    var characterId: Int
    
}
