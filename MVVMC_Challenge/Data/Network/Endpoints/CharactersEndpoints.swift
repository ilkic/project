//
//  CharactersEndpoint.swift
//  MVVMC_Challenge
//
//  Created by Onur on 16.01.2022.
//

import Moya
import CommonCrypto

enum CharactersEndpoints {
    case characters(limit: Int, offset: Int)
    case characterComics(characterId: Int, limit: Int, startYear: Int, orderBy: String)
}


extension CharactersEndpoints: TargetType {
    var privateKey: String {
        guard let key = Bundle.main.infoDictionary?["MarvelPrivateKey"] as? String else { fatalError("Need api key")}
        return key
    }
    
    var publicKey: String {
        guard let key = Bundle.main.infoDictionary?["MarvelPublicKey"] as? String else { fatalError("Need public key")}
        return key
    }
    
    
    
    
    var baseURL: URL {
        guard let urlString = Bundle.main.infoDictionary?["BaseUrl"] as? String, let url = URL(string: urlString) else { fatalError("Invalid base url") }
        return url
    }
    
    var path: String {
        switch self {
        case .characters:
            return "/characters"
        case .characterComics(let characterId, _, _, _):
            return "/characters/\(characterId)/comics"
        }
    }
    
    var method: Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        
        switch self {
        case .characters(let limit, let offset):
            return .requestParameters(parameters: defaultParameters + ["limit" : limit, "offset" : offset], encoding: URLEncoding.default)
        case .characterComics(_, let limit, let startYear, let orderBy):
            return .requestParameters(parameters: defaultParameters + ["startYear" : startYear, "orderBy" : orderBy, "limit" : limit], encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: defaultParameters, encoding: URLEncoding.default)
        }
    }
    
    private var defaultParameters: [String: Any] {
        let ts = "\(Int(Date().timeIntervalSince1970))"
        
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        return ["apikey" : publicKey,
                "hash" : hash,
                "ts" : ts]
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json",
                "Accept": "*/*"]
    }
    
    
    
}

fileprivate extension Dictionary {
    static func +(lhs: Self, rhs: Self) -> Dictionary {
        var lhs = lhs
        lhs.merge(rhs) { _ , new in new }
        return lhs
    }
    static func +<S: Sequence>(lhs: Self, rhs: S) -> Dictionary where S.Element == (Key, Value)  {
        var lhs = lhs
        lhs.merge(rhs) { _ , new in new }
        return lhs
    }
}
