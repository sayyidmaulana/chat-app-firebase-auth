//
//  GroupDetailView.swift
//  WhatsUp
//
//  Created by Sayyid Maulana Khakul Yakin on 12/07/23.
//

import SwiftUI
import FirebaseAuth

struct GroupDetailView: View {
    
    let group: Group
    @EnvironmentObject private var model: Model
    @State private var chatText: String = ""
    
    private func sendMessage() async throws {
        
        guard let currentUser = Auth.auth().currentUser else { return }
        
        let chatMessage = ChatMessage(text: chatText, uid: currentUser.uid, displayName: currentUser.displayName ?? "Guest")
        
        try await model.saveChatMessageTpGroup(chatMessage: chatMessage, group: group)
    }
    
    var body: some View {
        VStack {
            ChatMessageListView(chatMessages: model.chatMessages)
            TextField("Enter chat message", text: $chatText)
            Button("Send") {
                Task {
                    do {
                        try await sendMessage()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }.padding()
            .onDisappear {
                model.detachFirebaseListener()
            }
            .onAppear {
                model.listenForChatMessages(in: group)
            }
    }
}

struct GroupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GroupDetailView(group: Group(subject: "Movies"))
            .environmentObject(Model())
    }
}
