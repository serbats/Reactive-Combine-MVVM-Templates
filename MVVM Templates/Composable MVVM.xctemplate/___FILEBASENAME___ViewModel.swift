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
    
    func reduce(_ state: AppState, action: AppAction) -> AppState {
        var modifiedState = state
        
        switch action {
        case <#pattern#>:
            <#code#>
        default:
            break
        }
        
        return modifiedState
    }
    
    func convert(_ input: Input) -> AnyPublisher<AppAction, Never> {
        let actions = <#code#>
        return actions
    }
}

