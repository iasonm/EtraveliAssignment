//
//  Alerts.swift
//  EtraveliAssignment
//
//  Created by Iason Michailidis on 3/10/22.
//

import UIKit

struct Alerts {
    
    static func okAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        return alert
    }
    
    static func okCancelAlert(title: String, message: String, okAction: (() -> Void)?, cancelAction: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) {_ in
            okAction?()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) {_ in
            cancelAction?()
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        return alert
    }
    
}
