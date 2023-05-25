//
//  TokenDTO.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/17.
//

import Foundation

struct TokenDTO: Codable {
    private let access_token: String?
    private let scope: String?
    private let token_type: String?
    
    var data: Token {
        Token(
            access_token: self.access_token ?? "",
            scope: self.scope ?? "",
            token_type: self.token_type ?? ""
        )
    }
}

struct Token {
    let access_token: String
    let scope: String
    let token_type: String
}
