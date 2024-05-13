//
//  LoginView.swift
//  firebaseauth
//
//  Created by Иван Чернокнижников on 13.05.2024.
//

import SwiftUI

protocol AuthenticationFormProtocol {
    var formIsValid : Bool { get }
}
struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        NavigationStack {
            VStack {
                // Image
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 120)
                    .padding(.vertical,42)
                
                // Form fields
                VStack(spacing:24) {
                    InputView(text: $email, title: "Email Address", placeholder: "name@example.com")
                        .autocapitalization(.none)
                    
                    InputView(text: $password, title: "Password", placeholder: "Enter your password",isSecureField: true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                }
                .padding(.horizontal)
                .padding(.top,12)
                
                // Sign In Button
                Button {
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32,height: 48)
                .background(.blue)
                .cornerRadius(10)
                .padding(.top,24)
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1 : 0.5)
                
                Spacer()
                // Sign Up Button
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3) {
                        Text("Dont have an account?")
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
                
            }
        }
    }
}



// MARK -AuthenticationFormProtocol
extension LoginView : AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty && 
        email.contains("@") &&
        !password.isEmpty &&
        password.count > 5
    }
    
    
}

#Preview {
    LoginView()
}
