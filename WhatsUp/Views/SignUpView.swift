//
//  SignUpView.swift
//  WhatsUp
//
//  Created by Sayyid Maulana Khakul Yakin on 14/06/23.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var displayName: String = ""
    @State private var errorMessage: String = ""
    
    private var isFormValid: Bool {
        !email.isEmptyOrWhiteSpace && !password.isEmptyOrWhiteSpace && !displayName.isEmptyOrWhiteSpace
    }
    
    private func signUp() async {
        
        do {
            _ = try await Auth.auth().createUser(withEmail: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
        }
        
    }
    
    var body: some View {
        Form {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            TextField("Display Name", text: $displayName)
            
            HStack {
                Spacer()
                Button("Sign Up") {
                    Task {
                        await signUp()
                    }
                }.disabled(!isFormValid)
                    .buttonStyle(.borderless)
                Button("Login") {
                    // take the user to login screen
                    
                }.buttonStyle(.borderless)
                Spacer()

            }
            Text(errorMessage)
        
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
