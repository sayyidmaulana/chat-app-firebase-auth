//
//  AppState.swift
//  WhatsUp
//
//  Created by Sayyid Maulana Khakul Yakin on 22/06/23.
//

import Foundation

enum Route: Hashable {
    case main
    case login
    case signup
}

class AppState: ObservableObject {
    
    @Published var routes: [Route] = []
    
}
