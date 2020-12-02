//
//  
//  ComposedTimerViewViewModel.swift
//  SwiftUITestProj
//
//  Created by Serhii Batsevych on 02.12.2020.
//
//

import Foundation
import Combine
import CombineExt

final class ComposedTimerViewViewModel: ComposableViewModel {
    enum InputAction {
        case start
        case stop
        case restart
    }
    
    struct AppState {
        var time: Int
    }
    
    enum AppAction {
        case resetTime
        case incrementTime
    }
    
    let initialState: AppState
    
    init(initialState: AppState) {
        self.initialState = initialState
    }
    
    func reduce(_ state: AppState, action: AppAction) -> AppState {
        var modifiedState = state
        
        switch action {
        case .resetTime:
            modifiedState.time = 0
        case .incrementTime:
            modifiedState.time += 1
        }
        
        return modifiedState
    }
    
    func convert(_ inputAction: AnyPublisher<InputAction, Never>) -> AnyPublisher<AppAction, Never> {
        return inputAction
            .flatMapLatest { action -> AnyPublisher<AppAction, Never> in
                switch action {
                case .start:
                    return Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .default).autoconnect().map{ _ in AppAction.incrementTime }.eraseToAnyPublisher()
                case .restart:
                    return  Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .default).autoconnect().map{ _ in AppAction.incrementTime }.prepend(.resetTime).eraseToAnyPublisher()
                case .stop:
                    return Empty(outputType: AppAction.self, failureType: Never.self).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

