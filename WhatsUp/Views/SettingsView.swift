//
//  SettingsView.swift
//  WhatsUp
//
//  Created by Sayyid Maulana Khakul Yakin on 13/07/23.
//

import SwiftUI
import FirebaseAuth

struct SettingsConfig {
    var showPhotoOptions: Bool = false
    var sourceType: UIImagePickerController.SourceType?
    var selectedImage: UIImage?
    var displayName: String = ""
}

struct SettingsView: View {
    
    @State private var settingConfig = SettingsConfig()
    @FocusState var isEditing: Bool
    
    var displayName: String {
        guard let currentUser = Auth.auth().currentUser else { return "Guest" }
        return currentUser.displayName ?? "Guest"
    }
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle.fill")
                .rounded()
                .onTapGesture {
                    settingConfig.showPhotoOptions = true
                }.confirmationDialog("Select", isPresented: $settingConfig.showPhotoOptions) {
                    
                    Button("Camera") {
                        settingConfig.sourceType = .camera
                    }
                    
                    Button("Photo Library") {
                        settingConfig.sourceType = .photoLibrary
                    }
                }
            
            TextField(settingConfig.displayName, text: $settingConfig.displayName)
                .textFieldStyle(.roundedBorder)
                .focused($isEditing)
                .textInputAutocapitalization(.never)
            
            Spacer()
            
            Button("Signout") {
                
            }
            
        }.padding()
            .onAppear() {
                settingConfig.displayName = displayName
            }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
