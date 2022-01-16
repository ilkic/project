//
//  AppCoordinator.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import UIKit

class AppCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let characterListSceneDIContainer = appDIContainer.makeCharacterListSceneDIContainer()
        let flow = characterListSceneDIContainer.makeCharacterListFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}
