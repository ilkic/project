//
//  AppDIContainer.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import Foundation
import Moya

final class AppDIContainer {
    
    func makeCharacterListSceneDIContainer() -> CharacterListSceneDIContainer {
        var plugins: [PluginType] = []
        #if DEBUG
        let formatter = NetworkLoggerPlugin.Configuration.Formatter(requestData:{ (d) -> (String) in
            return JSONRequestDataFormatter(d)
        }, responseData: { (d) -> (String) in
            return JSONRequestDataFormatter(d)
        })
        
        //let logger = NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(formatter: formatter, logOptions: .verbose))
        let logger = NetworkLoggerPlugin()
        plugins.append(logger)
        #endif
        
        let provider = MoyaProvider<CharactersEndpoints>(plugins: plugins)
        let dependencies = CharacterListSceneDIContainer.Dependencies(provider: provider)
        return CharacterListSceneDIContainer(dependencies: dependencies)
    }
    
}
