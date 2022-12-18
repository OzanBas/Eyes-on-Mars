//
//  CuriosityViewController.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 17.12.2022.
//

import UIKit

class CuriosityViewController: UIViewController {
    
    //MARK: - Properties


    @IBOutlet weak var filterPopUpButton: EMFilterButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var roverModel: [Photo] = []
    var isFiltered = false
    var page: Int = 1
    
    
    var selectedCam: String? {
        didSet {
            networkCall(cam: selectedCam ?? "")

        }
    }
    
    
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        networkCall(cam: selectedCam ?? "")
        setPopUpButton()
    }
    
    
    
    
    
    
    //MARK: - Actions
    func networkCall(cam: String) {
        let service = NetworkManager.shared
        let urlString = service.urlCreator(rover: Endpoints.curiosity, page: page, camCodeName: selectedCam ?? "")
        
        
        service.request(urlString: urlString) { [weak self] (result: Result<RoverImageModel, EMError>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.roverModel = data.photos
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    

    
//MARK: - Configurations
    
    func setPopUpButton() {
        let optionClosure = {(action : UIAction) in
            print(action.title)
            if action.title == "All Cameras" {
                self.isFiltered = false
                self.selectedCam = nil
            } else {
                self.isFiltered = true
                self.selectedCam = action.title
            }
            
        }
        
        filterPopUpButton.menu = UIMenu(children: [
            UIAction(title: "All Cameras", state: .on, handler: optionClosure),
            UIAction(title: "FHAZ", handler: optionClosure),
            UIAction(title: "RHAZ", handler: optionClosure),
            UIAction(title: "MAST", handler: optionClosure),
            UIAction(title: "CHEMCAM", handler: optionClosure),
            UIAction(title: "MAHLI", handler: optionClosure),
            UIAction(title: "MARDI", handler: optionClosure),
            UIAction(title: "NAVCAM", handler: optionClosure)

            
        ])
        filterPopUpButton.showsMenuAsPrimaryAction = true
        filterPopUpButton.changesSelectionAsPrimaryAction = true
        
    }
    
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        configureCollectionView()
    }
    
        
    func configureCollectionView() {
        
        collectionView.collectionViewLayout = twoColumnFlowLayout(for: view)
        
        collectionView.register(UINib(nibName: RoverPhotoCell.reuseId, bundle: nil), forCellWithReuseIdentifier: RoverPhotoCell.reuseId)
        collectionView.dataSource = self
        
        }
    
}
    
extension CuriosityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roverModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoverPhotoCell.reuseId, for: indexPath) as! RoverPhotoCell
        print(roverModel.count)
        cell.set(with: roverModel[indexPath.row])

        
        return cell
    }
    
    
}


