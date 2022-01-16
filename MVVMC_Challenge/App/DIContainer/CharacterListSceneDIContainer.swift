//
//  CharacterListSceneDIContainer.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import UIKit
import Moya

final class CharacterListSceneDIContainer {
    
    struct Dependencies {
        let provider: MoyaProvider<CharactersEndpoints>
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeFetchCharacterListUseCase() -> FetchCharacterListUseCase {
        return DefaultFetchCharacterListUseCase(charactersRepository: makeCharactersRepository())
    }
    
    // MARK: - Repositories
    func makeCharactersRepository() -> CharactersRepository {
        return DefeaultCharactersRepository(provider: dependencies.provider)
    }
    
    // MARK: - Character List
    func makeCharacterListViewController(
        coordinator: CharacterListCoordinator
    ) -> CharacterListViewController {
        CharacterListViewController.create(
            with: makeCharacterListViewModel(coordinator: coordinator)
        )
    }
    
    func makeCharacterListViewModel(
        coordinator: CharacterListCoordinator
    ) -> CharacterListViewModel {
        return CharacterListViewModel(
            fetchCharacterUseCase: makeFetchCharacterListUseCase(),
            coordinator: coordinator
        )
    }
    
    // MARK: - Character Details
 
    func makeCharacterDetailsViewController(character: Character) -> CharacterDetailsViewController {
        return CharacterDetailsViewController.create(with: makeCharacterDetailsViewModel(character: character))
    }
    
    func makeFetchComicListUseCase() -> FetchComicListUseCase {
        return DefaultFetchComicListUseCase(charactersRepository: makeCharactersRepository())
    }
    

    func makeCharacterDetailsViewModel(character: Character) -> CharacterDetailsViewModel {
        return CharacterDetailsViewModel(character: character, useCase: makeFetchComicListUseCase())
    }

    // MARK: - Coordinators
    func makeCharacterListFlowCoordinator(
        navigationController: UINavigationController
    ) -> CharacterListCoordinator {
        return DefaultCharacterListCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }

}

extension CharacterListSceneDIContainer: CharacterListCoordinatorDependencies {}
