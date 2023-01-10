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
    
    
    func setFavoriteImage(detailVC: DetailsViewController) {
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let photos):
                if photos.contains(where: { $0 == detailVC.roverModel }) {
                    detailVC.favoritesButton.setImage(Images.favorite, for: .normal)
                } else {
                    detailVC.favoritesButton.setImage(Images.nonFavorite, for: .normal)
                }
            case .failure(let error):
                detailVC.presentEMAlertOnMainThread(title: "Error", message: error.rawValue, buttonText: "Ok")
            }
        }
    }
}
