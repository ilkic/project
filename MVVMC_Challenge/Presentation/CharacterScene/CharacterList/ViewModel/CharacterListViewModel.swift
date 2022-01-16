//
//  CharacterListViewModel.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

protocol CharacterListViewModelProtocol: ViewModelType { }

final class CharacterListViewModel: CharacterListViewModelProtocol {
    
    let characters: BehaviorSubject<[CharacterListItemViewModel]> = BehaviorSubject<[CharacterListItemViewModel]>(value: [])
    
    let loading = BehaviorRelay<Bool>(value: false)
       
    var pageIndex: Int = -1
       
    let error = PublishSubject<Swift.Error>()
       
    let disposeBag = DisposeBag()
       
    var isAllLoaded = false
    
    struct Input {
        let loadNextPageTrigger: PublishSubject<Void> = PublishSubject<Void>()
        
        let didSelectCell: Driver<CharacterListItemViewModel>
    }
    
    struct Output {
        let characters: BehaviorSubject<[CharacterListItemViewModel]>
        
        let fetching: Driver<Bool>
        
        let didSelectCell: Driver<CharacterListItemViewModel>
        
        let error: Driver<Error>
    }
    
    private let useCase: FetchCharacterListUseCase
    
    private let coordinator: CharacterListCoordinator
    
    init(fetchCharacterUseCase: FetchCharacterListUseCase,
         coordinator: CharacterListCoordinator) {
        self.useCase = fetchCharacterUseCase
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        let activityIndicator = ActivityIndicator()
        
        let errorTracker = ErrorTracker()
        
        let request = loading.asObservable()
            .sample(input.loadNextPageTrigger)
            .flatMapLatest { [unowned self] loading -> Observable<Int> in
                if loading {
                    return Observable.empty()
                } else {
                    guard !self.isAllLoaded else { return Observable.empty() }
                    
                    return Observable<Int>.create { [unowned self] observer in
                        debugPrint("page index: \(self.pageIndex)")
                        self.pageIndex += 1
                        observer.onNext(self.pageIndex)
                        observer.onCompleted()
                        return Disposables.create()
                    }
                }
            }.share(replay: 1)
        

       
        let response = request.flatMap { [unowned self] (page)
            -> Observable<[CharacterListItemViewModel]> in
            
            return self.useCase
                .execute(request: FetchCharacterListUseCaseRequestValue(offset: page * DefaultLimit))
                 .trackActivity(activityIndicator)
                 .trackError(errorTracker)
                 .catchAndReturn([])
                 .map {$0.map { c in
                     return CharacterListItemViewModel(character: c)
                 }}
            
        }.share(replay: 1)
        
       Observable
        .combineLatest(request, response, characters.asObservable()) { [weak self] _, response, characters in
            
            return self?.pageIndex == 0 ? response : characters + response
       }
       .sample(response)
       .bind(to: characters)
       .disposed(by: disposeBag)
        
        Observable
            .of(request.map {_ in true },
                   response.map { _ in false },
                   error.map { _ in false })
            .merge()
            .bind(to: loading)
            .disposed(by: disposeBag)
        
        let fetching = activityIndicator.asDriver()
        
        let didSelectCell = input.didSelectCell.do(onNext: { [weak self] (viewModel) in
            self?.coordinator.showCharacterDetails(character: viewModel.character)
        })
        
        return Output(characters: characters,
                    fetching: fetching,
                    didSelectCell: didSelectCell,
                    error: errorTracker.asDriver()
        )
        
    }
        
}
