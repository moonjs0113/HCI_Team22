//
//  GithubAPI.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/17.
//

import UIKit

final class GithubAPI {
    enum Key {
        case clientID
        case secretClientID
        
        var value: String {
            switch self {
            case .clientID: return "e3f5b6b0fa067208e4e7"
            case .secretClientID: return "5266ecdf29543db5208349027dddbea6fc215e2f"
            }
        }
    }
    
    internal static let requestManager = RequestManager()
    
    init() {
        
    }
}

extension GithubAPI {
    enum Login {
        static func requestOAuthCode() {
            let baseURLString = "https://github.com/login/oauth/authorize"
            let clientID = Key.clientID.value
            let scope = "repo_deployment"
            let authURLString = "\(baseURLString)?client_id=\(clientID)&scope=\(scope)"
            guard let authURL = URL(string: authURLString) else {
                return
            }
            UIApplication.shared.open(authURL)
        }
        
        static func requestAccessToken(code: String, completeHandler: @escaping NetworkClosure) {
            let route = "https://github.com/login/oauth/access_token"
            let parameter = [
                "client_id" : Key.clientID.value,
                "client_secret" : Key.secretClientID.value,
                "code" : code,
            ]
            
            requestManager.requestPOST(
                route: route,
                parameter: parameter,
                completeHandler: completeHandler
            )
        }
        
        static func requestUserInfo(completeHandler: @escaping GenericClosure<UserDTO>) {
            let route = "https://api.github.com/user"
            requestManager.requestGET(route: route, completeHandler: completeHandler)
        }
        
        static func requestRepoInfo(completeHandler: @escaping GenericClosure<ReposDTO>) {
            let route = "https://api.github.com/user/repos"
            requestManager.requestGET(route: route, completeHandler: completeHandler)
        }
        
        static func requestCommitInfo(userName: String, repoName: String, completeHandler: @escaping GenericClosure<AllCommitDTO>) {
            let route = "https://api.github.com/repos/"+userName+"/"+repoName+"/stats/participation"
            
            requestManager.requestGET(route: route, completeHandler: completeHandler)
        }
    }
}
