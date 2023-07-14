//
//  AppState.swift
//  WhatsUp
//
//  Created by Sayyid Maulana Khakul Yakin on 22/06/23.
//

import Foundation

enum LoadingState: Hashable, Identifiable {
    case idle
    case loading(String)
    
    var id: Self {
        return self
    }
 }

enum Route: Hashable {
    case main
    case login
    case signup
}

class AppState: ObservableObject {
    @Published var loadingState: LoadingState = .idle
    @Published var routes: [Route] = []
    @Published var errorWrapper: ErrorWrapper?
}
