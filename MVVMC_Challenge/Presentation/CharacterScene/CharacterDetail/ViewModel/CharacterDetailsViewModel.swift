//
//  CharacterDetailViewModel.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay


protocol CharacterDetailsViewModelProtocol: ViewModelType {}

final class CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
   
    let disposeBag = DisposeBag()

    
    struct Input {
        
    }
    
    struct Output {
        let title: String
        let description: String
        let imageUrl: String
        
        let comics: Driver<[CharacterDetailsComicListItemViewModel]>
        
        let fetching: Driver<Bool>
        
        let error: Driver<Error>
    }
    
    private let character: Character
    private let useCase: FetchComicListUseCase


    init(character: Character, useCase: FetchComicListUseCase) {
        self.character = character
        self.useCase = useCase
    }
    
    func transform(input: Input) -> Output {
        
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
                   
        let comics = self.useCase.execute(request: .init(characterId: character.id))
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .catchAndReturn([])
                        .share(replay: 1)
                        .asDriverOnErrorJustComplete()
                        .map { $0.map { CharacterDetailsComicListItemViewModel(comic: $0) } }
                
                
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
            
        return Output(title: character.name,
                      description: character.description,
                      imageUrl: character.imageUrl,
                      comics: comics,
                      fetching: fetching,
                      error: errors)
    }
}
