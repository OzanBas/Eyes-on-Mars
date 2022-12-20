//
//  EMDataRequesterVC.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 20.12.2022.
//

import UIKit

class EMDataRequesterVC: UIViewController {

    var contentView: UIView!
    
    func showActivityIndicator() {
        
        contentView = UIView(frame: view.bounds)
        contentView.backgroundColor = .systemBackground
        contentView.alpha = 0.6
        
        UIView.animate(withDuration: 0.25) {self.contentView.alpha = 0.8}
        
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissActivityIndicator() {
        DispatchQueue.main.async {
            self.contentView.removeFromSuperview()
            self.contentView = nil
        }
    }

}
