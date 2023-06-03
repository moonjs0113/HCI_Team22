//
//  DateComponents+Extension.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/06/02.
//

import Foundation

extension DateComponents {
    var toString: String {
        guard let date = self.date else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
