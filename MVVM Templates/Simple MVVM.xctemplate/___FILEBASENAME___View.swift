//___FILEHEADER___

import SwiftUI
import Combine

struct ___VARIABLE_productName:identifier___View: View {
    let viewModel: ___VARIABLE_productName:identifier___ViewModel
    let output: ___VARIABLE_productName:identifier___ViewModel.Output
    
    init (viewModel: ___VARIABLE_productName:identifier___ViewModel) {
        self.viewModel = viewModel
        
        let input = /*@START_MENU_TOKEN@*/___VARIABLE_productName:identifier___ViewModel.Input/*@END_MENU_TOKEN@*/ 
        
        output = viewModel.bind(input)
    }
    
    var body: some View {
        Group {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .onReceive(output./*@START_MENU_TOKEN@*/somePublisherProperty/*@END_MENU_TOKEN@*/, perform: { value in
            self./*@START_MENU_TOKEN@*/some@StateProperty/*@END_MENU_TOKEN@*/ = value
        })
    }
}

struct ___VARIABLE_productName:identifier___Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_productName:identifier___View(viewModel: /*@START_MENU_TOKEN@*/___VARIABLE_productName:identifier___ViewModel/*@END_MENU_TOKEN@*/)
    }
}

