//
//  User.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/23.
//

import Foundation

struct UserDTO: Codable {
    private let name: String?
    private let email: String?
    private let avatar_url: String?
    private let events_url: String?
    private let login: String? // ID
    
    var data: User {
        User(
            name: login ?? "",
            email: email ?? "",
            avatarURL: avatar_url ?? "",
            eventsURL: events_url ?? ""
//            id: login ?? ""
        )
    }
}

struct User {
    let name: String
    let email: String
    let avatarURL: String
    let eventsURL: String
//    let id: String
}


