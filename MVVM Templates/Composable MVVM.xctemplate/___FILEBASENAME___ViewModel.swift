//
//  ___FILEHEADER___
//

import Foundation
import Combine
import CombineExt

final class ___VARIABLE_productName:identifier___ViewModel: ComposableViewModel {
    enum InputAction {
        case <#case#>
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
    
    func convert(_ inputAction: AnyPublisher<InputAction, Never>) -> AnyPublisher<AppAction, Never> {
        return inputAction
            .flatMapLatest { action -> AnyPublisher<AppAction, Never> in
                switch action {
                case <#pattern#>:
                    <#code#>
                default:
                    return Empty(outputType: AppAction.self, failureType: Never.self).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

