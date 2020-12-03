//
//  ___FILEHEADER___
//

import Foundation
import Combine
import CombineExt

final class ___VARIABLE_productName:identifier___ViewModel: ComposableViewModel {
    struct Input {
        <#fields#>
    }
    
    struct AppState {
        <#fields#>
    }
    
    enum AppAction {
        case <#case#>
    }
    
    let initialState: AppState
    
    init(initialState: AppState) {
        self.initialState = initialState
    }
    
    func reduce(_ state: inout AppState, action: AppAction) {
        switch action {
        case <#pattern#>:
            <#code#>
        }
    }
    
    func convert(_ input: Input) -> AnyPublisher<AppAction, Never> {
        let actions = <#code#>
        return actions
    }
}

