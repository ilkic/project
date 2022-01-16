//
//  CharacterListCoordinator.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import Foundation
import UIKit

protocol CharacterListCoordinatorDependencies {
    
    func makeCharacterListViewController(coordinator: CharacterListCoordinator) -> CharacterListViewController
    
    func makeCharacterDetailsViewController(character: Character) -> CharacterDetailsViewController
}

protocol CharacterListCoordinator {
    
    func start()
    
    func showCharacterDetails(character: Character)
}

class DefaultCharacterListCoordinator: CharacterListCoordinator {
    
    private let navigationController: UINavigationController
    
    private let dependencies: CharacterListCoordinatorDependencies
    
    private weak var characterListVC: CharacterListViewController?
    
    init(navigationController: UINavigationController,
         dependencies: CharacterListCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeCharacterListViewController(coordinator: self)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showCharacterDetails(character: Character) {
        let vc = dependencies.makeCharacterDetailsViewController(character: character)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
