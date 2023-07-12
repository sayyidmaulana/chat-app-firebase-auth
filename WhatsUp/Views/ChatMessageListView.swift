//
//  ChatMessageListView.swift
//  WhatsUp
//
//  Created by Sayyid Maulana Khakul Yakin on 12/07/23.
//

import SwiftUI

struct ChatMessageListView: View {
    
    let chatMessages: [ChatMessage]
    
    var body: some View {
        VStack {
            List(chatMessages) { chatMessage in
                Text(chatMessage.text)
            }
        }
    }
}

struct ChatMessageListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageListView(chatMessages: [])
    }
}
