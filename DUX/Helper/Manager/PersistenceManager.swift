//
//  PersistenceManager.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/17.
//

import Foundation

final class PersistenceManager {
    enum Key: String {
        case userID
        case goals
    }
    
    static let shared: PersistenceManager  = .init()
    
    var uds: UserDefaults {
        UserDefaults.standard
    }
    
    // USER TOKEN
    func saveUserToken(value: String) {
        uds.set(value, forKey: Key.userID.rawValue)
    }
    
    func getUserToken() -> String? {
        uds.string(forKey: Key.userID.rawValue)
    }
    
    // USER GOAL
    func saveGoals(value: String) {
        uds.set(value, forKey: Key.goals.rawValue)
    }
    
    func getGoals() -> String? {
        uds.string(forKey: Key.goals.rawValue)
    }
    
    init() {
        
    }
}
