//
//  EmptyStateView.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 22.12.2022.
//

import UIKit


class EMEmptyStateView: UIView {
    
    //MARK: - Properties
    let messageLabel = EMInfoLabel()
    let logoImageView = UIImageView()
    let explanatoryLabel = EMDiscriptionLabel()
    var roverViewModel: RoverViewModel?
    var favoritesViewModel: FavoritesViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
        
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    convenience init(message: String, image: UIImage) {
        self.init(frame: .zero)
        messageLabel.text = message
        logoImageView.image = image
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    //MARK: - Actions
    func checkToDisplayForFavorites(for vc: FavoritesViewController) {
        messageLabel.text = "Your favorites list is empty."
        explanatoryLabel.text = "You may add photos using the 'star' icon in photo details."
        
        var favorites: [Photo] = []
        
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let photos):
                favorites = photos
            case .failure(let error):
                vc.presentEMAlertOnMainThread(title: "Error", message: error.rawValue, buttonText: "Ok")
            }
        }
        
        
        if favorites.count == 0 {
            isHidden = false
        } else {
            isHidden = true
        }
    }
    
    
    func checkToDisplayforRover(viewModel: RoverViewModel) {
        let filteredPhotoCount = viewModel.filteredRoverModel.count
        let photoCount = viewModel.roverModel.count

        
        if viewModel.isFiltered == false, photoCount == 0, viewModel.isLoadingMorePhotos == false {
            isHidden = false
            messageLabel.text = "No results for selected date."
        }
        if viewModel.isFiltered == true, filteredPhotoCount == 0, viewModel.isLoadingMorePhotos == false {
            isHidden = false
            messageLabel.text = "\(photoCount) photo(s) downloaded but there are none taken with \(viewModel.selectedCam)."
        } else {
            isHidden = true
        }
    }
    
    
    //MARK: - Configurations
    func configure() {
        configureMessageLabel()
        configureLogoImageView()
        configureExplanatoryLabel()
    }
    
    private func configureExplanatoryLabel() {
        addSubview(explanatoryLabel)
        explanatoryLabel.translatesAutoresizingMaskIntoConstraints = false
        explanatoryLabel.numberOfLines = 2
        explanatoryLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            explanatoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            explanatoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            explanatoryLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10),
            explanatoryLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func configureMessageLabel() {
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font = .systemFont(ofSize: 25, weight: .bold)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func configureLogoImageView() {
        addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        var width: CGFloat { return UIScreen.main.bounds.width }
        var height: CGFloat { return UIScreen.main.bounds.width }
        
        logoImageView.image = UIImage(systemName: "camera.filters")
        logoImageView.tintColor = .orange
        logoImageView.backgroundColor = .systemBackground
        logoImageView.contentMode = .scaleAspectFit
        
        
        NSLayoutConstraint.activate([
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -height / 5),
            logoImageView.heightAnchor.constraint(equalToConstant: height / 2),
            logoImageView.widthAnchor.constraint(equalToConstant: width / 1.5)
        ])
    }
}
