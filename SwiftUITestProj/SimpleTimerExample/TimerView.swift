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
    
    @SubjectBinding var text: String = ""
    
    init(viewModel: TimerViewModel) {
        self.viewModel = viewModel
        
        let input = TimerViewModel.Input(startTap: start.eraseToAnyPublisher(),
                                         stopTap: stop.eraseToAnyPublisher(),
                                         resetTap: reset.eraseToAnyPublisher(),
                                         textChanged: _text.anyPublisher())
        
        output = viewModel.bind(input)
    }
    
    var body: some View {
        VStack {
            Text("Simple View Model")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            HStack {
                Text("Text added to timer")
                TextField("One More Time", text: $text)
            }
            
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
        .onReceive(output.timerWithText, perform: { time in
            self.time = time
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var diManager: DependencyInjectionProtocol {
        return DependencyInjectionManager()
    }
    
    static var previews: some View {
        diManager.simpleTimerView()
    }
}
