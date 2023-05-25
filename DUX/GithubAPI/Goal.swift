//
//  Goal.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/24.
//

import Foundation

struct Goal {
    var deadline: DateComponents
    var count: Int
    var type: GoalType = .commit
    
//    var previewData: [Goal] {
//        [
//            .init(deadline: .now, count: 10, type: .commit),
//            .init(deadline: .now, count: 3, type: .commit),
//            .init(deadline: .now, count: 7, type: .commit),
//        ]
//    }
}

enum GoalType {
    case commit
    case pullRequest
    case issue
}
