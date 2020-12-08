//
//  ComposableViewModel.swift
//  SwiftUITestProj
//
//  Created by Serhii Batsevych on 02.12.2020.
//

import Foundation
import Combine
import CombineExt

protocol ComposableViewModel: AbstractViewModel where Output == AnyPublisher<AppState, Never> {
    associatedtype AppState
    associatedtype AppAction
    
    var initialState: AppState { get }
    
    func reduce(_ state: inout AppState, action: AppAction)
    func convert(_ input: Input, stateSubject: CurrentValueSubject<AppState, Never>) -> AnyPublisher<AppAction, Never>
}

extension ComposableViewModel {
    private func prepareReduce(_ state: AppState, action: AppAction) -> AppState {
        var modifiedState = state
        
        reduce(&modifiedState, action: action)
        
        return modifiedState
    }
    
    func bind(_ input: Input) -> AnyPublisher<AppState, Never> {
        let stateSubject = CurrentValueSubject<AppState, Never>(initialState)
        
        return convert(input, stateSubject: stateSubject)
            .withLatestFrom(stateSubject) { prepareReduce($1, action: $0) }
            .handleEvents(receiveOutput: stateSubject.send)
            .prepend(initialState)
            .share(replay: 1)
            .eraseToAnyPublisher()
    }
}
