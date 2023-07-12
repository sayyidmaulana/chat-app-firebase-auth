//
//  ChatMessageView.swift
//  WhatsUp
//
//  Created by Sayyid Maulana Khakul Yakin on 12/07/23.
//

import SwiftUI

enum ChatMessageDirection {
    case left
    case right
}

struct ChatMessageView: View {
    
    let chatMessage: ChatMessage
    let direction: ChatMessageDirection
    let color: Color
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading, spacing: 5) {
                Text(chatMessage.displayName)
                    .opacity(0.8)
                    .font(.caption)
                    .foregroundColor(.white)
                
                Text(chatMessage.text)
                Text(chatMessage.dateCreated, format: .dateTime)
                    .font(.caption)
                    .opacity(0.4)
                    .frame(maxWidth: 200, alignment: .trailing)
            }.padding(8)
                .background(color)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            
        }.listRowSeparator(.hidden)
            .overlay(alignment: direction == .left ? .bottomLeading : .bottomTrailing) {
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.title)
                    .rotationEffect(.degrees(direction == .left ? 45 : -45))
                    .offset(x: direction == .left ? 30 : -30, y: 10)
                    .foregroundColor(color)
            }
        
    }
}

struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageView(chatMessage: ChatMessage(documentId: "ABCD", text: "Hello World", uid: "QWERTY", dateCreated: Date(), displayName: "johndoe"), direction: .right, color: .blue)
    }
}
