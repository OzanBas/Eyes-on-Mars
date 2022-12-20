//
//  FavoritesCell.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 20.12.2022.
//

import UIKit

class FavoritesCell: UITableViewCell {

    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var infoLabel: EMInfoLabel!
    @IBOutlet weak var descriptiveLabel: EMDiscriptionLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(roverModel: Photo) {
        
        let rover = (roverModel.rover?.name)?.capitalized
        let date = roverModel.earthDate
        let camera = roverModel.camera?.name
        let cameraFull = roverModel.camera?.fullName
        
        if let image = roverModel.imgSrc {
            cellImageView.setImageWithKingFisher(with: image)
        }
        infoLabel.text = "\(rover ?? "null."), \(date ?? "")"
        descriptiveLabel.text = "\(camera ?? "null.")(\(cameraFull ?? "null."))"
    }
    
    
}
