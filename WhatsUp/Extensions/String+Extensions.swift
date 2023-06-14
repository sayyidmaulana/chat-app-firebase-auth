//
//  String+Extensions.swift
//  WhatsUp
//
//  Created by Sayyid Maulana Khakul Yakin on 14/06/23.
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
