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
    
    func reduce(_ state: AppState, action: AppAction) -> AppState
    func convert(_ inputAction: Input) -> AnyPublisher<AppAction, Never>
}

extension ComposableViewModel {
    func bind(_ input: Input) -> AnyPublisher<AppState, Never> {
        let stateSubject = CurrentValueSubject<AppState, Never>(initialState)
        
        return convert(input)
            .withLatestFrom(stateSubject) { reduce($1, action: $0) }
            .handleEvents(receiveOutput: stateSubject.send)
            .prepend(initialState)
            .share(replay: 1)
            .eraseToAnyPublisher()
    }
}
