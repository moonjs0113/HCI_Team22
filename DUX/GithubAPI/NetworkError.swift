//
//  NetworkError.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/17.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case nilResponse
//    case nilImageData
    case managerIsNil
    case errorEncodingJson
    case errorDecodingJson
    case errorConvertString
    case failCreateBodyData
}
