//
//  AppDelegate.swift
//  MVVMC_Challenge
//
//  Created by Onur on 15.01.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appDIContainer = AppDIContainer()
    var appCoordinator: AppCoordinator?
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        window?.rootViewController = navigationController
        appCoordinator = AppCoordinator(navigationController: navigationController,
                                                    appDIContainer: appDIContainer)
        appCoordinator?.start()
        window?.makeKeyAndVisible()
        return true
    }

   

}

