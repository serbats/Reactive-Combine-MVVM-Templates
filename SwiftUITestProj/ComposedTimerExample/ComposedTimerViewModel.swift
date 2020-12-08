//
//  
//  ComposedTimerViewModel.swift
//  SwiftUITestProj
//
//  Created by Serhii Batsevych on 02.12.2020.
//
//

import Foundation
import Combine
import CombineExt

final class ComposedTimerViewModel: ComposableViewModel {
    struct Input {
        var startTimer: AnyPublisher<Void, Never>
        var stopTimer: AnyPublisher<Void, Never>
        var resetTimer: AnyPublisher<Void, Never>
        var textChanged: AnyPublisher<String, Never>
    }
    
    struct AppState {
        var time: Int = 0
        var text: String = ""
    }
    
    enum AppAction {
        case resetTime
        case incrementTime
        case modifyText(String)
    }
    
    struct AppEnvironment {
        var timer: TimerProtocol.Type
    }
    
    var environment: AppEnvironment!
    
    let initialState: AppState
    
    init(initialState: AppState) {
        self.initialState = initialState
    }
    
    func reduce(_ state: inout AppState, action: AppAction) {
        switch action {
        case .incrementTime:
            state.time += 1
        case .resetTime:
            state.time = 0
        case .modifyText(let text):
            state.text = text
        }
    }
    
    func convert(_ input: Input, stateSubject: CurrentValueSubject<AppState, Never>) -> AnyPublisher<AppAction, Never> {
        enum TimerActions {
            case start
            case stop
            case reset
        }
        
        let timer = Publishers.Merge3(input.startTimer.map { TimerActions.start }, input.stopTimer.map { TimerActions.stop }, input.resetTimer.map { TimerActions.reset })
            .flatMapLatest { action -> AnyPublisher<Void, Never> in
                switch action {
                case .start, .reset:
                    return self.environment.timer.timerPublisher(1.0).map { _ in () }.eraseToAnyPublisher()
                case .stop:
                    return Empty(outputType: Void.self, failureType: Never.self).eraseToAnyPublisher()
                }
            }
        
        let actions = Publishers.Merge3(timer.map { AppAction.incrementTime }, input.resetTimer.map { AppAction.resetTime }, input.textChanged.map { AppAction.modifyText($0) })
            .eraseToAnyPublisher()
        return actions
    }
}
