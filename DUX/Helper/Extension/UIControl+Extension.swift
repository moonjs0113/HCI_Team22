//
//  UIControl+Extension.swift
//  DUX
//
//  Created by Moon Jongseek on 2023/05/17.
//

import UIKit
import Combine

protocol UIControlPublishable: UIControl {
    
}

extension UIControlPublishable {
    func publisher(for event: UIControl.Event) -> UIControl.InteractionPublisher<Self> {
        return InteractionPublisher(control: self, event: event)
    }
}

extension UIControl: UIControlPublishable {
    struct InteractionPublisher<C: UIControl>: Publisher {
        typealias Output = C
        typealias Failure = Never
        
        private weak var control: C?
        private let event: UIControl.Event
        
        init(control: C, event: UIControl.Event) {
            self.control = control
            self.event = event
        }
        
        func receive<S>(subscriber: S) where S: Subscriber, S.Failure == Never, C == S.Input {
            guard let control = control else {
                subscriber.receive(completion: .finished)
                return
            }
            
            let subscription = InteractionSubscription(
                subscriber: subscriber,
                control: control,
                event: event
            )
            
            subscriber.receive(subscription: subscription)
        }
    }
    
    class InteractionSubscription<S: Subscriber, C: UIControl>: Subscription where S.Input == C {
        private let subscriber: S?
        private weak var control: C?
        private let event: UIControl.Event
        
        init(subscriber: S, control: C?, event: UIControl.Event) {
            self.subscriber = subscriber
            self.control = control
            self.event = event
            self.control?.addTarget(self, action: #selector(handleEvent), for: event)
        }
        
        @objc private func handleEvent(_ sender: UIControl) {
            guard let control = self.control else {
                return
            }
            _ = self.subscriber?.receive(control)
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            self.control?.removeTarget(self, action: #selector(handleEvent), for: self.event)
            self.control = nil
        }
    }
    
}

