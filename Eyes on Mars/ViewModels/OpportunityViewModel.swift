//
//  OpportunityViewModel.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 20.12.2022.
//

import Foundation


class OpportunityViewModel {
    
    var delegate: UIUpdateProtocol?
    var roverModel: [Photo] = []
    var page: Int = 1
    var isLoadingMorePhotos = false
    var isMorePhotosAvailable = true
    
    var selectedDate: String = "2016-12-19" {
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
        let urlString = NetworkManager.shared.urlCreator(rover: Endpoints.opportunity, page: page, camCodeName: selectedCam, earthDate: selectedDate)
        
        delegate?.willStartLoading()
        isLoadingMorePhotos = true
        NetworkManager.shared.request(urlString: urlString) { [weak self] (result: Result<RoverImageModel, EMError>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if data.photos.count < 25 { self.isMorePhotosAvailable = false }
                self.roverModel.append(contentsOf: data.photos)
                self.delegate?.didFinishLoading()
                self.delegate?.didRecieveData()
            case .failure(let error):
                self.delegate?.didFinishLoading()
                self.delegate?.didRecieveError(error: error)
            }
        }
        isLoadingMorePhotos = false
    }
}
