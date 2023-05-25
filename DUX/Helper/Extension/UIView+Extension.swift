//
//  UIView+Extension.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/23.
//

import UIKit
import Combine

extension UIView {
    func publisher(type: GestureType) -> GesturePublisher {
        .init(view: self, gestureType: type)
    }
    
    func bindCircleLayout(anyCancellable: inout Set<AnyCancellable>) {
        clipsToBounds = true
        self.publisher(for: \.bounds, options: [.new, .initial, .old, .prior])
            .receive(on: DispatchQueue.main)
            .filter { trunc($0.width) == trunc($0.height) }
            .map { $0.width / 2 }
            .assign(to: \.layer.cornerRadius, on: self)
            .store(in: &anyCancellable)
    }
}
