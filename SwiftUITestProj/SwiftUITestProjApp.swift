//
//  SwiftUITestProjApp.swift
//  SwiftUITestProj
//
//  Created by Serhii Batsevych on 18.11.2020.
//

import SwiftUI

@main
struct SwiftUITestProjApp: App {
    let diManager: DependencyInjectionProtocol = DependencyInjectionManager()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                diManager.simpleTimerView()
                diManager.composableTimerView()
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
}
