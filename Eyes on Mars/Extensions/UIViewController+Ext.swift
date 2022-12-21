//
//  UIViewController+Ext.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 20.12.2022.
//

import UIKit


extension UIViewController {
    
    func presentEMAlertOnMainThread(title: String, message: String, buttonText: String) {
        DispatchQueue.main.async {
            let alertVC =  EMAlertViewController(title: title, message: message, buttonText: buttonText)
            alertVC.modalPresentationStyle = .popover
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
