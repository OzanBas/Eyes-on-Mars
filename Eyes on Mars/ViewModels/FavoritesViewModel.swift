//
//  FavoritesViewModel.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 20.12.2022.
//

import Foundation

class FavoritesViewModel {
    
    var roverModel: [Photo] = []
    var delegate: UIUpdateProtocol?
    
    func loadFavorites() {
        delegate?.willStartLoading()
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photos):
                self.roverModel = photos
                print(self.roverModel.count)
                self.delegate?.didRecieveData()
                self.delegate?.didFinishLoading()
            case .failure(let error):
                self.delegate?.didRecieveError(error: error)
                self.delegate?.didFinishLoading()
            }
        }
    }
    
}
