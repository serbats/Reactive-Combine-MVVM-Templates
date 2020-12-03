//
//  TimerViewModel.swift
//  SwiftUITestProj
//
//  Created by Serhii Batsevych on 18.11.2020.
//

import Foundation
import Combine
import CombineExt

final class TimerViewModel: AbstractViewModel {
    
    let startTime: Int = 0
    
    struct Input {
        var startTap: AnyPublisher<Void, Never>
        var stopTap: AnyPublisher<Void, Never>
        var resetTap: AnyPublisher<Void, Never>
        var textChanged: AnyPublisher<String, Never>
    }
    
    struct Output {
        var timer: AnyPublisher<String, Never>
    }
    
    
    func bind(_ input: Input) -> Output {
        enum TimerState {
            case running
            case stopped
            case reset
        }
        
        let savedTime = CurrentValueSubject<Int, Never>(startTime)
        
        let timer = Publishers.Merge3(input.startTap.map{ TimerState.running } , input.stopTap.map{ TimerState.stopped }, input.resetTap.map{ TimerState.reset } )
            .map { state -> AnyPublisher<Int, Never> in
                switch state {
                case .running:
                    return Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .default).autoconnect()
                        .withLatestFrom(savedTime)
                        .map { $0 + 1 }
                        .eraseToAnyPublisher()
                case .stopped:
                    return Empty(outputType: Int.self, failureType: Never.self).eraseToAnyPublisher()
                case .reset:
                    return Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .default).autoconnect()
                        .scan(self.startTime, { (currentTime, timer) -> Int in
                            currentTime + 1
                        })
                        .prepend(self.startTime)
                        .eraseToAnyPublisher()
                }
            }
            .switchToLatest()
            .handleEvents(receiveOutput: { currentTime in
                savedTime.send(currentTime)
            })
            .prepend(startTime)
        
        let timerAndText = Publishers.CombineLatest(input.textChanged, timer)
            .map { text, time in
                text.isEmpty ? "\(time)" : "\(text):\(time)"
            }
            .eraseToAnyPublisher()
        
        let output = Output(timer: timerAndText)
        return output
    }
}
