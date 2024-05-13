//
//  firebaseauthApp.swift
//  firebaseauth
//
//  Created by Иван Чернокнижников on 13.05.2024.
//

import SwiftUI
import Firebase
@main
struct firebaseauthApp: App {
    
    @StateObject var viewModel = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
