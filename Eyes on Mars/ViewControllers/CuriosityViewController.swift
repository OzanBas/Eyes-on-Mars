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
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var roverModel: [Photo] = []
    var page: Int = 1
    var isLoadingMorePhotos = false
    var isMorePhotosAvailable = true
    
    var selectedDate: String = "2016-12-19" {
        didSet {
            roverModel = []
            isMorePhotosAvailable = true
            networkCall()
        }
    }
    
    var selectedCam: String = "" {
        didSet {
            roverModel = []
            networkCall()
            print(datePicker.date.inNasaFormat())
        }
    }
    
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        networkCall()
    }
    
    
//MARK: - Actions
    func networkCall() {
        let service = NetworkManager.shared
        let urlString = service.urlCreator(rover: Endpoints.curiosity, page: page, camCodeName: selectedCam, earthDate: selectedDate)
        print(urlString)
        
        isLoadingMorePhotos = true
        service.request(urlString: urlString) { [weak self] (result: Result<RoverImageModel, EMError>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if data.photos.count < 25 { self.isMorePhotosAvailable = false }
                    self.roverModel.append(contentsOf: data.photos)
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
        isLoadingMorePhotos = false
    }
    
    
    @objc func dateSelected() {
        selectedDate = datePicker.date.inNasaFormat()
    }
    
    
//MARK: - Configurations
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        configureCollectionView()
        setPopUpButton()
        configureDatePicker()

        
    }
    
    
    func setPopUpButton() {
        let optionClosure = {(action : UIAction) in
            self.isMorePhotosAvailable = true
            print(action.title)
            if action.title == "All Cameras" {
                self.selectedCam = ""
            } else {
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
    
    
    func configureDatePicker() {
        datePicker.tintColor = .orange
        
        datePicker.addTarget(self, action: #selector(dateSelected), for: .editingDidEnd)
    }
    

    func configureCollectionView() {
        
        collectionView.collectionViewLayout = twoColumnFlowLayout(for: view)
        collectionView.register(UINib(nibName: RoverPhotoCell.reuseId, bundle: nil), forCellWithReuseIdentifier: RoverPhotoCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
        }
}

//MARK: - CollectionView Extension
extension CuriosityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roverModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoverPhotoCell.reuseId, for: indexPath) as! RoverPhotoCell
        cell.set(with: roverModel[indexPath.row])

        
        return cell
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y               // shows how much you scrolled down
        let contentHeight = scrollView.contentSize.height       // shows initial content height
        let height = scrollView.frame.size.height + 147           // height of scrollview for current device
        
        print("\(offsetY) must be more than \(contentHeight-height)")
        
        if offsetY > contentHeight - height {
            guard isMorePhotosAvailable, !isLoadingMorePhotos else { return }
            page += 1
            print(page)
            networkCall()
            
        }
    }
    
    
}


