//
//  GroupListContainerView.swift
//  WhatsUp
//
//  Created by Sayyid Maulana Khakul Yakin on 22/06/23.
//

import SwiftUI

struct GroupListContainerView: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("New Group") {
                    isPresented = true
                }
            }
            
            Spacer()
        }.padding()
            .sheet(isPresented: $isPresented) {
                AddNewGroupView()
            }
    }
}

struct GroupListContainerView_Previews: PreviewProvider {
    static var previews: some View {
        GroupListContainerView()
    }
}
