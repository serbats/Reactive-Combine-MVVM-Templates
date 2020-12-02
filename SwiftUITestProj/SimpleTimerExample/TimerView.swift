//
//  ContentView.swift
//  SwiftUITestProj
//
//  Created by Serhii Batsevych on 18.11.2020.
//

import SwiftUI
import Combine

struct TimerView: View {
    @State var time: String = ""
    
    var viewModel: TimerViewModel
    var output: TimerViewModel.Output
    
    
    let start = PassthroughSubject<Void, Never>()
    let stop = PassthroughSubject<Void, Never>()
    let reset = PassthroughSubject<Void, Never>()
    
    init(viewModel: TimerViewModel) {
        self.viewModel = viewModel
        
        let input = TimerViewModel.Input(startTap: start.eraseToAnyPublisher(),
                                         stopTap: stop.eraseToAnyPublisher(),
                                         resetTap: reset.eraseToAnyPublisher())
        
        output = viewModel.bind(input)
    }
    
    var body: some View {
        VStack {
            Text(time)
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
        .onReceive(output.timer, perform: { time in
            self.time = time
        })
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(viewModel: TimerViewModel())
    }
}
