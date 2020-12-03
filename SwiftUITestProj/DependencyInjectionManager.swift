//
//  DependencyInjectionManager.swift
//  SwiftUITestProj
//
//  Created by Serhii Batsevych on 03.12.2020.
//

import Foundation
import Combine

protocol TimerProtocol {
    static var timerPublisher: (TimeInterval) -> AnyPublisher<Date, Never> { get }
}

extension Timer: TimerProtocol {
    static var timerPublisher: (TimeInterval) -> AnyPublisher<Date, Never> {
        return { interval in
            Self.TimerPublisher(interval: interval, runLoop: .main, mode: .default).autoconnect().eraseToAnyPublisher()
        }
    }
}

protocol DependencyInjectionProtocol {
    func simpleTimerView() -> TimerView
    func simpleTimerViewModel() -> TimerViewModel
    
    func composableTimerView() -> ComposedTimerView
    func composableTimerViewModel() -> ComposedTimerViewModel
    
    var timer: TimerProtocol.Type { get }
}

class DependencyInjectionManager: DependencyInjectionProtocol {
    func simpleTimerView() -> TimerView {
        let viewModel = simpleTimerViewModel()
        
        let view = TimerView(viewModel: viewModel)
        return view
    }
    
    func simpleTimerViewModel() -> TimerViewModel {
        let viewModel = TimerViewModel()
        
        let env = TimerViewModel.AppEnvironment(timer: timer)
        
        viewModel.environment = env
        
        return viewModel
    }
    
    func composableTimerView() -> ComposedTimerView {
        let viewModel = composableTimerViewModel()
        
        let view = ComposedTimerView(viewModel: viewModel)
        return view
    }
    
    func composableTimerViewModel() -> ComposedTimerViewModel {
        let viewModel = ComposedTimerViewModel(initialState: ComposedTimerViewModel.AppState())
        
        let env = ComposedTimerViewModel.AppEnvironment(timer: timer)
        
        viewModel.environment = env
        
        return viewModel
    }
    
    var timer: TimerProtocol.Type {
        return Timer.self
    }
}
