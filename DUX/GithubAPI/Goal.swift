//
//  Goal.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/24.
//

import Foundation

struct Goal: Codable {
    var startDay: String
    var deadline: String
    var count: Int
    var type: GoalType = .commit
}

enum GoalType: Codable {
    case commit
    case pullRequest
    case issue
}
