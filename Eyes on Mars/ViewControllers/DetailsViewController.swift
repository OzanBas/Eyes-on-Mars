//
//  DetailsViewController.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 19.12.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    var roverModel: Photo!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailCardView: DetailsCardView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    init(roverModel: Photo) {
        super.init(nibName: "DetailsViewController", bundle: nil)
        self.roverModel = roverModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        
        view.backgroundColor = .systemGray6
        topView.backgroundColor = .systemGray6
        titleLabel.text = "Details"
        detailCardView.set(roverModel: roverModel)
        
        imageView.backgroundColor = .systemGray4
        imageView.layer.cornerRadius = 15
        if let imageUrl = roverModel.imgSrc {
            imageView.setImageWithKingFisher(with: imageUrl)
            
        }
    }
    
    
}
