//
//  ContentView.swift
//  firebaseauth
//
//  Created by Иван Чернокнижников on 13.05.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
 
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                
                ProfileView()
            }
            else {
                LoginView()
                
            }
        }
    
    }
}

#Preview {
    ContentView()
}
