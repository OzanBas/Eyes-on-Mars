//
//  DetailsViewController.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 19.12.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
//MARK: - Properties

    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    var roverModel: Photo!
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
            self.presentEMAlertOnMainThread(title: "Note:", message: error.rawValue, buttonText: "Ok")
        }
    }
    
    
    @IBAction func exitButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
//MARK: - Configurations
    func configureViewController() {
        
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
        favoritesButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        favoritesButton.tintColor = .orange
    }
}
