//___FILEHEADER___

import SwiftUI
import Combine

struct ___VARIABLE_productName:identifier___View: View {
    @State var state: ___VARIABLE_productName:identifier___ViewModel.AppState
    
    let viewModel: ___VARIABLE_productName:identifier___ViewModel
    let output: ___VARIABLE_productName:identifier___ViewModel.Output
    
    let input = PassthroughSubject<___VARIABLE_productName:identifier___ViewModel.InputAction, Never>()
    
    init (viewModel: ___VARIABLE_productName:identifier___ViewModel) {
        _state = State(wrappedValue: viewModel.initialState)
        
        self.viewModel = viewModel
        
        output = viewModel.bind(input.eraseToAnyPublisher())
    }
    
    var body: some View {
        Group {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .onReceive(output, perform: { state in
            self.state = state
        })
    }
}

struct ___VARIABLE_productName:identifier___Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_productName:identifier___View(viewModel: ___VARIABLE_productName:identifier___ViewModel(initialState: /*@START_MENU_TOKEN@*/___VARIABLE_productName:identifier___ViewModel.AppState/*@END_MENU_TOKEN@*/))
    }
}

