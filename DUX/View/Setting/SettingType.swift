//
//  SettingType.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/23.
//

import Foundation

enum SettingType: CaseIterable {
    case notification
    case reset
    case logout
    
    var title: String {
        switch self {
        case .notification: return "알림 설정"
        case .reset:        return "목표 초기화"
        case .logout:       return "로그아웃"
        }
    }
}
