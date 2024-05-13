//
//  RegistrationView.swift
//  firebaseauth
//
//  Created by Иван Чернокнижников on 13.05.2024.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 100,height: 120)
                .padding(.vertical,42)
            
            VStack(spacing:24) {
                InputView(text: $email, title: "Email Address", placeholder: "name@example.com")
                    .autocapitalization(.none)
                InputView(text: $fullName, title: "Full Name", placeholder: "Enter your name")
                
                InputView(text: $password, title: "Password", placeholder: "Enter your password",isSecureField: true)
                    .autocapitalization(.none)
                
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword, title: "Confirm Password", placeholder: "Confirn your password",isSecureField: true)
                        .autocapitalization(.none)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(.green)
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top,12)
            
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email, password:password, fullName:fullName)
                }
            } label: {
                HStack {
                    Text("SIGN UP")
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
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
    }
}


// MARK -AuthenticationFormProtocol
extension RegistrationView : AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullName.isEmpty
    }
    
    
}


#Preview {
    RegistrationView()
}
