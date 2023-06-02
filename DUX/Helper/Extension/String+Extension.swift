//
//  String+Extension.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/06/02.
//

import Foundation

extension String {
    var toDateComponents: DateComponents {
        let components = self.components(separatedBy: "-")
        return DateComponents(
            calendar: .current,
            year: Int(components[0]),
            month: Int(components[1]),
            day: Int(components[2])
        )
    }
}
