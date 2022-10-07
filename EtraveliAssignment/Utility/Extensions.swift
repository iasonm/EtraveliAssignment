//
//  Extensions.swift
//  EtraveliAssignment
//
//  Created by Iason Michailidis on 3/10/22.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
    
}

extension String {
    
    var isBlank: Bool {
        trimmingCharacters(in: .whitespaces).isEmpty
    }
    
}

extension String? {
    
    var emptyOnNil: String {
        return self == nil ? "" : self!
    }

}

