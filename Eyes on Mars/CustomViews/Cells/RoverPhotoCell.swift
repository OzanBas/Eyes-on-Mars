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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//MARK: - Configuration
    func set(with data: RoverImageModel, at indexPath: Int) {
        let roverName = data.photos[indexPath].rover?.name ?? "Null"
        let camName = data.photos[indexPath].camera?.name ?? "Cam unknown"
        
        infoLabel.text = "\(roverName) on \(camName)"
        
    }
    
    
}
