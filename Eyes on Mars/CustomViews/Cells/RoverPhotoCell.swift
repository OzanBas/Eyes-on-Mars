//
//  RoverPhotoCell.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 17.12.2022.
//

import UIKit

class RoverPhotoCell: UICollectionViewCell {

    static let reuseId = "RoverPhotoCell"
    
    @IBOutlet weak var roverImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }

//MARK: - Configuration
    
    func configureCell() {
        
        roverImage.layer.cornerRadius = 15
        roverImage.contentMode = .scaleAspectFill
        
    }
    
    
    func set(with roverModel: Photo) {
        let roverName = roverModel.rover?.name ?? "Null"
        let camName = roverModel.camera?.name ?? "Cam unknown"
        
        infoLabel.text = "\(roverName) on \(camName)"
        if let image = roverModel.imgSrc {
            DispatchQueue.main.async {
                self.roverImage.setImageWithKingFisher(with: image)

            }
        }
    }
    
    
}
