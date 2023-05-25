//
//  UIdf.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/17.
//

import UIKit
import Combine

enum GestureType {
    case tap
    case swipe
    case longPress
    case pan
    case pinch
    case edge
    
    var recognizer: UIGestureRecognizer {
        switch self {
        case .tap: return UITapGestureRecognizer()
        case .swipe: return UISwipeGestureRecognizer()
        case .longPress: return UILongPressGestureRecognizer()
        case .pan: return UIPanGestureRecognizer()
        case .pinch: return UIPinchGestureRecognizer()
        case .edge: return UIScreenEdgePanGestureRecognizer()
        }
    }
}

struct GesturePublisher: Publisher {
    typealias Output = GestureType
    typealias Failure = Never
    
    private let view: UIView
    private let gestureType: GestureType
    
    init(view: UIView, gestureType: GestureType) {
        self.view = view
        self.gestureType = gestureType
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = GestureSubscription(
            subscriber: subscriber,
            view: view,
            gestureType: gestureType
        )
        subscriber.receive(subscription: subscription)
    }
}

final class GestureSubscription<S: Subscriber>: Subscription where S.Input == GestureType, S.Failure == Never {
    private var subscriber: S?
    private var gestureType: GestureType
    private var view: UIView
    
    init(
        subscriber: S,
        view: UIView,
        gestureType: GestureType
    ) {
        self.subscriber = subscriber
        self.view = view
        self.gestureType = gestureType
        configure(gestureType: gestureType)
    }
    
    private func configure(gestureType: GestureType) {
        let gesture = gestureType.recognizer
        gesture.addTarget(self, action: #selector(action(_:)))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
    }
    
    func request(_ demand: Subscribers.Demand) {
        
    }
    
    func cancel() {
        subscriber = nil
    }
    
    @objc private func action(_ sender: UITapGestureRecognizer) {
        _ = subscriber?.receive(gestureType)
    }
}


