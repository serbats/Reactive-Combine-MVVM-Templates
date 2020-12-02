//
//  SubjectBinding.swift
//  TimelessToday
//
//  Created by Serhii Batsevych on 27.05.2020.
//  Copyright © 2020 Serhii Batsevych. All rights reserved.
//

import Combine
import SwiftUI

@propertyWrapper
struct SubjectBinding<Value> {
    private let subject: CurrentValueSubject<Value, Never>

    init(wrappedValue: Value) {
        subject = CurrentValueSubject<Value, Never>(wrappedValue)
    }

    func anyPublisher() -> AnyPublisher<Value, Never> {
        return subject.eraseToAnyPublisher()
    }

    var wrappedValue: Value {
        get {
            return subject.value
        }
        set {
            subject.value = newValue
        }
    }

    var projectedValue: Binding<Value> {
        return Binding<Value>(get: { () -> Value in
            return self.subject.value
        }) { (value) in
            self.subject.value = value
        }
    }
}
