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
    
    let initialState: AppState
    
    init(initialState: AppState) {
        self.initialState = initialState
    }
    
    func reduce(_ state: AppState, action: AppAction) -> AppState {
        var modifiedState = state
        
        switch action {
        case .incrementTime:
            modifiedState.time += 1
        case .resetTime:
            modifiedState.time = 0
        case .modifyText(let text):
            modifiedState.text = text
        }
        
        return modifiedState
    }
    
    func convert(_ input: Input) -> AnyPublisher<AppAction, Never> {
        enum TimerActions {
            case start
            case stop
            case reset
        }
        
        let timer = Publishers.Merge3(input.startTimer.map { TimerActions.start }, input.stopTimer.map { TimerActions.stop }, input.resetTimer.map { TimerActions.reset })
            .flatMapLatest { action -> AnyPublisher<Void, Never> in
                switch action {
                case .start, .reset:
                    return Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .default).autoconnect().map { _ in () }.eraseToAnyPublisher()
                case .stop:
                    return Empty(outputType: Void.self, failureType: Never.self).eraseToAnyPublisher()
                }
            }
            .map { AppAction.incrementTime }
        
        let resetAction = input.resetTimer
            .map { AppAction.resetTime }
        
        let modifyText = input.textChanged
            .map { AppAction.modifyText($0) }
        
        let actions = Publishers.Merge3(timer, resetAction, modifyText)
            .eraseToAnyPublisher()
        return actions
    }
}

