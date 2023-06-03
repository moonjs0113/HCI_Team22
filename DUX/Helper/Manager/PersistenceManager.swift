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
    func saveGoal(value: Goal) {
        var goalList: [Goal] = getGoals() ?? []
        goalList.append(value)
        guard let data = try? PropertyListEncoder().encode(goalList) else {
            return
        }
        uds.set(data, forKey: Key.goals.rawValue)
    }
    
    func getGoals() -> [Goal]? {
        guard let data = uds.data(forKey: Key.goals.rawValue) else {
            return nil
        }
        return try? PropertyListDecoder().decode([Goal].self, from: data)
    }
    
    init() {
        
    }
}
