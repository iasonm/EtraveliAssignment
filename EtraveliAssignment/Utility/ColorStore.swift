//
//  ColorStore.swift
//  EtraveliAssignment
//
//  Created by Iason Michailidis on 4/10/22.
//

import UIKit

enum ColorStore {
    
    case detailBackground, detailLabelText
    
    var color: UIColor {
        switch self {
        case .detailBackground: return UIColor(red: 0.42, green: 0.42, blue: 0.42, alpha: 1.00)
        case .detailLabelText: return UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1.00)
        }
    }
    
}


