//
//  AllCommit.swift
//  DUX
//
//  Created by dohankim on 2023/06/01.
//

import Foundation

struct AllCommitDTO: Codable {
    private let all: [Int]?
    private let owner: [Int]?
    
    var data: AllCommit {
        AllCommit(
            all: all ?? [0],
            owner: owner ?? [0]
        )
    }
}

struct AllCommit {
    let all: [Int]
    let owner: [Int]
    
}
