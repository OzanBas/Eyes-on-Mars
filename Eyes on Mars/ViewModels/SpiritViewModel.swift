//
//  SpiritViewModel.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 19.12.2022.
//

import Foundation

class SpiritViewModel {
    
    var delegate: viewModelProtocol?
    var roverModel: [Photo] = []
    var page: Int = 1
    var isLoadingMorePhotos = false
    var isMorePhotosAvailable = true
    
    var selectedDate: String = "2009-02-20" {
        didSet {
            roverModel = []
            isMorePhotosAvailable = true
            requestNetworkCall()
        }
    }
    
    var selectedCam: String = "" {
        didSet {
            roverModel = []
            requestNetworkCall()
        }
    }
    
    func requestNetworkCall() {
        let urlString = NetworkManager.shared.urlCreator(rover: Endpoints.spirit, page: page, camCodeName: selectedCam, earthDate: selectedDate)
        
        isLoadingMorePhotos = true
        NetworkManager.shared.request(urlString: urlString) { (result: Result<RoverImageModel, EMError>) in
            
            switch result {
            case .success(let data):
                if data.photos.count < 25 { self.isMorePhotosAvailable = false }
                self.roverModel.append(contentsOf: data.photos)
                self.delegate?.updateData()
            case .failure(let error):
                print(error.rawValue)
            }
        }
        isLoadingMorePhotos = false
    }
}
