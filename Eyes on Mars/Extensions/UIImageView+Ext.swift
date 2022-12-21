//
//  UIImageView+Ext.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 18.12.2022.
//

import UIKit
import Kingfisher


extension UIImageView {
    
    func setImageWithKingFisher(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        kf.setImage(with: url)
    }
}
