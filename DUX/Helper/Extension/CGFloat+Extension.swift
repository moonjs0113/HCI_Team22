//
//  CGFloat+Extension.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/23.
//

import Foundation

extension CGFloat {
    /// Layout 간격 4배수로 고정
    static func layoutConstant(_ multiple: Int = 5) -> CGFloat {
        CGFloat(multiple * 4)
    }
    
    var minus: Self {
        return self * -1
    }
}
