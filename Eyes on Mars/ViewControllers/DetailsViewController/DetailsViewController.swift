//
//  DetailsViewController.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 19.12.2022.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    //MARK: - Properties

    
    var roverModel: Photo!
    var delegate: UIUpdateProtocol?
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailCardView: DetailsCardView!
    
    
    init(roverModel: Photo) {
        super.init(nibName: "DetailsViewController", bundle: nil)
        self.roverModel = roverModel
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }

    
    //MARK: - Actions
    @IBAction func favoritesButtonTapped(_ sender: UIButton) {
        
        PersistenceManager.update(favorite: roverModel) { error in
            guard let error = error else { return }
            self.presentEMAlertOnMainThread(title: "Updated:", message: error.rawValue, buttonText: "Ok")
        }
        DispatchQueue.main.async { self.favoritesButton.imageView?.setFavoriteImage(detailVC: self) }
    }
    
    
    @IBAction func exitButtonTapped(_ sender: UIButton) {
        delegate?.didRecieveData()
        self.dismiss(animated: true)
    }
    
    
    //MARK: - Configurations
    private func configureViewController() {
        
        view.backgroundColor = .systemGray6
        topView.backgroundColor = .systemGray6
        titleLabel.text = "Details"
        detailCardView.set(roverModel: roverModel)
        configureFavoriteButton()
        
        imageView.backgroundColor = .systemGray4
        imageView.layer.cornerRadius = 15
        if let imageUrl = roverModel.imgSrc {
            imageView.setImageWithKingFisher(with: imageUrl)
        }
    }
    
    
    private func configureFavoriteButton() {
        favoritesButton.imageView?.setFavoriteImage(detailVC: self)
        favoritesButton.tintColor = .orange
        favoritesButton.contentMode = .scaleAspectFill
    }
}
