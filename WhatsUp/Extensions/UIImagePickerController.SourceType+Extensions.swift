//
//  UIImagePickerController.SourceType+Extensions.swift
//  WhatsUp
//
//  Created by Sayyid Maulana Khakul Yakin on 14/07/23.
//

import Foundation
import UIKit

extension UIImagePickerController.SourceType: Identifiable {
    public var id: Int {
        switch self {
        case .camera:
            return 1
        case .photoLibrary:
            return 2
        case .savedPhotosAlbum:
            return 3
        @unknown default:
            return 4
        }
    }
}
