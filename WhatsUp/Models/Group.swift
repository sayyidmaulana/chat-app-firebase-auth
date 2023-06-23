//
//  Group.swift
//  WhatsUp
//
//  Created by Sayyid Maulana Khakul Yakin on 23/06/23.
//

import Foundation


struct Group: Codable, Identifiable {
    var documentId: String? = nil
    let subject: String
    
    var id: String {
        documentId ?? UUID().uuidString
    }
}

extension Group {
    
    func toDictionary() -> [String: Any] {
        return ["subject": subject]
    }
    
}
