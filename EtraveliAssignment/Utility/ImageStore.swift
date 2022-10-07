//
//  ImageStore.swift
//  EtraveliAssignment
//
//  Created by Iason Michailidis on 4/10/22.
//

import UIKit

enum ImageStore {
    
    case eyeSlashSquare, eyeSlashRect
    
    var image: UIImage {
        switch self {
        case .eyeSlashSquare: return UIImage(named: "eyeSlashSquare")!
        case .eyeSlashRect: return UIImage(named: "eyeSlashRect")!
        }
    }
    
}
