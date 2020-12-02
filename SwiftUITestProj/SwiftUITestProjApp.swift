//
//  SwiftUITestProjApp.swift
//  SwiftUITestProj
//
//  Created by Serhii Batsevych on 18.11.2020.
//

import SwiftUI

@main
struct SwiftUITestProjApp: App {
    var body: some Scene {
        WindowGroup {
            TimerView(viewModel: TimerViewModel())
            ComposedTimerViewView(viewModel: ComposedTimerViewViewModel(initialState: ComposedTimerViewViewModel.AppState(time: 0)))
        }
    }
}
