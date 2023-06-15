//
//  LoginView.swift
//  WhatsUp
//
//  Created by Sayyid Maulana Khakul Yakin on 15/06/23.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    private var isFormValid: Bool {
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace
    }
    
    private func login() async {
        
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            // go to the main screen
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    var body: some View {
        Form {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            
            HStack {
                Spacer()
                Button("Login") {
                    Task {
                        await login()
                    }
                }.disabled(!isFormValid)
                .buttonStyle(.borderless)
                Button("Register") {
                    // go to the registration page
                }.buttonStyle(.borderless)
                Spacer()

            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
