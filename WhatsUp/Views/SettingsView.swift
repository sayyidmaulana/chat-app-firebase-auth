//
//  SettingsView.swift
//  WhatsUp
//
//  Created by Sayyid Maulana Khakul Yakin on 13/07/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage

struct SettingsConfig {
    var showPhotoOptions: Bool = false
    var sourceType: UIImagePickerController.SourceType?
    var selectedImage: UIImage?
    var displayName: String = ""
}

struct SettingsView: View {
    
    @State private var settingConfig = SettingsConfig()
    @FocusState var isEditing: Bool
    @EnvironmentObject private var model: Model
    
    @State private var currentPhotoURL: URL? = Auth.auth().currentUser?.photoURL
    
    var displayName: String {
        guard let currentUser = Auth.auth().currentUser else { return "Guest" }
        return currentUser.displayName ?? "Guest"
    }
    
    var body: some View {
        NavigationView {
            VStack {
                AsyncImage(url: currentPhotoURL) { image in
                    image.rounded()
                } placeholder: {
                    Image(systemName: "person.crop.circle.fill")
                        .rounded()
                }.onTapGesture {
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
                
            }
            .sheet(item: $settingConfig.sourceType, content: { sourceType in
                ImagePicker(image: $settingConfig.selectedImage, sourceType: sourceType)
            })
            .onChange(of: settingConfig.selectedImage, perform: { image in
                
                // resize image
                // https://stackoverflow.com/questions/31314412/how-to-resize-image-in-swift
                guard let img = image,
                      let resizedImage = img.resize(to: CGSize(width: 100, height: 100)),
                      let imageData = resizedImage.pngData()
                else { return }
                
                // upload the image to firebase storage to get the url
                Task {
                    guard let currentUser = Auth.auth().currentUser else { return }
                    let filename = "\(currentUser.uid).png"
                    
                    do {
                        let url = try await Storage.storage().uploadData(for: filename, data: imageData, bucket: .photos)
                        try await model.updatePhotoURL(for: currentUser, photoURL: url)
                        currentPhotoURL = url
                        
                    } catch {
                        print(error)
                    }
                }
                
            })
            .padding()
            .onAppear() {
                settingConfig.displayName = displayName
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        
                        guard let currentUser = Auth.auth().currentUser else { return }
                        Task {
                            do {
                                try await model.updateDisplayName(for: currentUser, displayName: settingConfig.displayName)
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
            })
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Model())
    }
}
