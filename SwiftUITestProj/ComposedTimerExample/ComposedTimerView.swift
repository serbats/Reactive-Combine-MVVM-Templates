//
//  ComposedTimerView.swift
//  SwiftUITestProj
//
//  Created by Serhii Batsevych on 02.12.2020.
//

import SwiftUI
import Combine

struct ComposedTimerView: View {
    @State var state: ComposedTimerViewModel.AppState
    
    let viewModel: ComposedTimerViewModel
    let output: ComposedTimerViewModel.Output
    
    let start = PassthroughSubject<Void, Never>()
    let stop = PassthroughSubject<Void, Never>()
    let reset = PassthroughSubject<Void, Never>()
    
    @SubjectBinding var text: String = ""
    
    init (viewModel: ComposedTimerViewModel) {
        _state = State(wrappedValue: viewModel.initialState)
        
        self.viewModel = viewModel
        
        let input = ComposedTimerViewModel.Input(startTimer: start.eraseToAnyPublisher(),
                                                 stopTimer: stop.eraseToAnyPublisher(),
                                                 resetTimer: reset.eraseToAnyPublisher(),
                                                 textChanged: _text.anyPublisher())
        output = viewModel.bind(input)
    }
    
    var body: some View {
        VStack {
            Text("Composable View Model")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            HStack {
                Text("Text added to timer")
                TextField("One More Time", text: $text)
            }
            
            Text(state.text.isEmpty ? "\(state.time)" : "\(state.text):\(state.time)")
                .padding()
            
            Button("Start") {
                start.send()
            }
            
            Button("Stop") {
                stop.send()
            }
            
            Button("Reset") {
                reset.send()
            }
        }
        .onReceive(output, perform: { state in
            self.state = state
        })
    }
}

struct ComposedTimerPreviews: PreviewProvider {
    static var diManager: DependencyInjectionProtocol {
        return DependencyInjectionManager()
    }
    
    static var previews: some View {
        diManager.composableTimerView()
    }
}
