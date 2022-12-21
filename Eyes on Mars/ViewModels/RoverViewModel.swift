//
//  RoverViewModel.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 20.12.2022.
//

import Foundation

final class RoverViewModel {
 
    init(rover: String, defaultDate: String) {
        self.rover = rover
        self.selectedDate = defaultDate
    }
    

    //MARK: - Properties
    let rover: String!
    var delegate: UIUpdateProtocol?
    var roverModel: [Photo] = []
    var filteredRoverModel: [Photo] = []
    var page: Int = 1
    var isLoadingMorePhotos = false
    var isMorePhotosAvailable = true
    var isFiltered = false
    
    var selectedDate: String! {
        didSet {
            roverModel = []
            filteredRoverModel = []
            isMorePhotosAvailable = true
            page = 1
            requestNetworkCall()
        }
    }
    
    var selectedCam: String = "" {
        didSet {
            filteredRoverModel = roverModel.filter({ $0.camera?.name == selectedCam })
            print("filtered: \(filteredRoverModel.count)")
            delegate?.didRecieveData()
        }
    }
    
    
    //MARK: - Actions
    func requestNetworkCall() {
        let urlString = NetworkManager.shared.urlCreator(rover: rover, page: page, earthDate: selectedDate)

        delegate?.willStartLoading()
        isLoadingMorePhotos = true
        NetworkManager.shared.request(urlString: urlString) { [weak self] (result: Result<RoverImageModel, EMError>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if data.photos.count < 25 { self.isMorePhotosAvailable = false }
                self.roverModel.append(contentsOf: data.photos)
                
                let filteredData = data.photos.filter { $0.camera?.name == self.selectedCam }
                self.filteredRoverModel = filteredData

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
