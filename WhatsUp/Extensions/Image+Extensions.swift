//
//  Image+Extensions.swift
//  WhatsUp
//
//  Created by Sayyid Maulana Khakul Yakin on 13/07/23.
//

import Foundation
import SwiftUI

extension Image {
    
    func rounded(width: CGFloat = 100, height: CGFloat = 100) -> some View {
        return self.resizable()
            .frame(width: width, height: height)
            .clipShape(Circle())
    }
    
}
