//
//  ComposedTimerViewView.swift
//  SwiftUITestProj
//
//  Created by Serhii Batsevych on 02.12.2020.
//

import SwiftUI
import Combine

struct ComposedTimerViewView: View {
    @State var state: ComposedTimerViewViewModel.AppState
    
    let viewModel: ComposedTimerViewViewModel
    let output: ComposedTimerViewViewModel.Output
    
    let input = PassthroughSubject<ComposedTimerViewViewModel.InputAction, Never>()
    
    init (viewModel: ComposedTimerViewViewModel) {
        _state = State(wrappedValue: viewModel.initialState)
        
        self.viewModel = viewModel
        
        output = viewModel.bind(input.eraseToAnyPublisher())
    }
    
    var body: some View {
        VStack {
            Text("\(state.time)")
                .padding()
            
            Button("Start") {
                input.send(.start)
            }
            
            Button("Stop") {
                input.send(.stop)
            }
            
            Button("Reset") {
                input.send(.restart)
            }
        }
        .onReceive(output, perform: { state in
            self.state = state
        })
    }
}

struct ComposedTimerViewPreviews: PreviewProvider {
    static var previews: some View {
        ComposedTimerViewView(viewModel: ComposedTimerViewViewModel(initialState: ComposedTimerViewViewModel.AppState(time: 0)))
    }
}

