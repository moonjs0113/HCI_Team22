//
//  RequestManager.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/17.
//

import Foundation

typealias NetworkClosure = (Result<Data,NetworkError>) -> Void
typealias GenericClosure<D: Codable> = (D) -> Void

final class RequestManager {
    var session = URLSession(
        configuration: .default,
        delegate: nil,
        delegateQueue: nil
    )

    let request: (_ url: URL,_ method: HTTPMethod, _ body: Data?) -> URLRequest = { url, method, body in
        var request = URLRequest(url: url)
        if let token = PersistenceManager.shared.getUserToken() {
            request.addValue("token \(token)", forHTTPHeaderField: "Authorization")
        }
        request.addValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = method.rawValue
        request.httpBody = body
        return request
    }
    
    func showErrorAlertController(error: NetworkError) {
        DispatchQueue.main.async {
            WindowManager.shared.showAlertController(title: "네트워크 에러", message: "error: \(error)")
        }
    }

    init() {
        
    }

    deinit {
        self.session.finishTasksAndInvalidate()
    }
}


