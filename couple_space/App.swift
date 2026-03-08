//
//  App.swift
//  couple_space
//
//  Created by Emanuel on 07.03.26.
//

import SwiftUI

@main
struct CoupleSpaceApp : App {
    
    @State var isLoggedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                ContentView()
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
