//
//  RequestManager+ResultClosure.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/23.
//

import Foundation

// NetworkClosure
extension RequestManager {
    func requestWithURL(
        urlString: String,
        completeHandler: @escaping NetworkClosure
    ) {
        guard let url = URL(string: urlString) else {
            completeHandler(.failure(.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        sendRequest(request: request, completeHandler: completeHandler)
    }
    
    /// Get Method NetworkClosure
    func requestGET(
        route: String,
        parameter: [String: String] = [:],
        completeHandler: @escaping NetworkClosure
    ) {
        var urlString = route + "?"
        parameter.forEach {
            urlString += "\($0.key)=\($0.value)&"
        }
        _ = urlString.removeLast()

        guard let url = URL(string: urlString) else {
            completeHandler(.failure(.invalidURL))
            return
        }

        let request = self.request(url, .GET, nil)
        sendRequest(request: request, completeHandler: completeHandler)
    }
    
    func requestPOST<P: Codable>(
        route: String,
        parameter: P? = nil,
        completeHandler: @escaping NetworkClosure
    ) {
        var bodyData: Data?
        if let parameter = parameter {
            guard let jsonData = try? JSONEncoder().encode(parameter) else {
                completeHandler(.failure(.errorEncodingJson))
                return
            }
            bodyData = jsonData
        }
        
        guard let url = URL(string: route) else {
            completeHandler(.failure(.invalidURL))
            return
        }
        
        let request = self.request(url, .POST, bodyData)
        sendRequest(request: request, completeHandler: completeHandler)
    }
    
    /// NetworkClosure
    private func sendRequest(
        request: URLRequest,
        completeHandler: @escaping NetworkClosure
    ) {
        self.session.dataTask(with: request) { responseData, response, error in
            guard let responseData = responseData, error == nil else {
                completeHandler(.failure(.nilResponse))
                return
            }
            DispatchQueue.main.async {
                completeHandler(.success(responseData))
            }
        }
        .resume()
    }
}
