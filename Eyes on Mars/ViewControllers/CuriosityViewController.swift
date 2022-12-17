//
//  CuriosityViewController.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 17.12.2022.
//

import UIKit

class CuriosityViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    var mockData: RoverImageModel?

    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        networkCall()
    }
    
    //MARK: - Actions
    func networkCall() {
        NetworkManager.shared.request(for: Endpoints.curiosity, page: 1) { [weak self] (result: Result<RoverImageModel, EMError>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.mockData = data
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    

    
//MARK: - Configurations
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
        return mockData?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoverPhotoCell.reuseId, for: indexPath) as! RoverPhotoCell
        
        if let mockData = mockData {
            cell.set(with: mockData, at: indexPath.row)
        }
        
        return cell
    }
    
    
}

