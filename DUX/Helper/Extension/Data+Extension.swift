//
//  Data+Extension.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/23.
//

import Foundation

extension Data {
    var prettyPrintedJSONString: String {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]) else {
            return ""
        }
        return String(decoding: data, as: UTF8.self)
    }
}

