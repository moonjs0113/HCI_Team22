//
//  RequestManager+Generic.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/23.
//

import Foundation

// GenericClosure
extension RequestManager {
    /// Get Method NetworkClosure
    func requestGET<D: Codable>(
        route: String,
        parameter: [String: String] = [:],
        completeHandler: @escaping GenericClosure<D>
    ) {
        var urlString = route + "?"
        parameter.forEach {
            urlString += "\($0.key)=\($0.value)&"
        }
        _ = urlString.removeLast()

        guard let url = URL(string: urlString) else {
            showErrorAlertController(error: .invalidURL)
            return
        }

        let request = self.request(url, .GET, nil)
        sendRequest(request: request, completeHandler: completeHandler)
    }
    
    func requestPOST<D: Codable, P: Codable>(
        route: String,
        parameter: P? = nil,
        completeHandler: @escaping GenericClosure<D>
    ) {
        var bodyData: Data?
        if let parameter = parameter {
            guard let jsonData = try? JSONEncoder().encode(parameter) else {
                showErrorAlertController(error: .errorEncodingJson)
                return
            }
            bodyData = jsonData
        }
        
        guard let url = URL(string: route) else {
            showErrorAlertController(error: .invalidURL)
            return
        }
        
        let request = self.request(url, .POST, bodyData)
        sendRequest(request: request, completeHandler: completeHandler)
    }
    
    /// NetworkClosure
    private func sendRequest<D: Codable>(
        request: URLRequest,
        completeHandler: @escaping GenericClosure<D>
    ) {
        self.session.dataTask(with: request) { [weak self] responseData, response, error in
            guard let responseData = responseData, error == nil else {
                
                self?.showErrorAlertController(error: .nilResponse)
                return
            }
            
            do {
                print("------")
                print(responseData)
                print(responseData.prettyPrintedJSONString)
                let data = try JSONDecoder().decode(D.self, from: responseData)
                DispatchQueue.main.async {
                    completeHandler(data)
                }
            } catch (let e) {
                debugPrint(e)
                self?.showErrorAlertController(error: .errorDecodingJson)
            }
        }
        .resume()
    }
}
