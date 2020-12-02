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
            ComposedTimerView(viewModel: ComposedTimerViewModel(initialState: ComposedTimerViewModel.AppState()))
        }
    }
}
