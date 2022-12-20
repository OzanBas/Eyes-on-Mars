//
//  DetailsCardView.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 19.12.2022.
//

import UIKit

class DetailsCardView: UIView {
    

    private var roverNameValue      = EMDiscriptionLabel()
    private var landingDateValue    = EMDiscriptionLabel()
    private var launchDateValue     = EMDiscriptionLabel()
    private var stasusValue         = EMDiscriptionLabel()
    private var cameraNameValue     = EMDiscriptionLabel()
    private var photodateValue      = EMDiscriptionLabel()
    private var martianSolValue     = EMDiscriptionLabel()

    private var roverName   = EMInfoLabel(title: "Rover:")
    private var landingDate = EMInfoLabel(title: "Landing date:")
    private var stasus      = EMInfoLabel(title: "Stasus")
    private var launchDate  = EMInfoLabel(title: "Launch date:")
    private var cameraName  = EMInfoLabel(title: "Camera:")
    private var photoDate   = EMInfoLabel(title: "Photo date:")
    private var martianSol  = EMInfoLabel(title: "Sol(Mars date):")

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    
    func set(roverModel: Photo) {
        self.roverNameValue.text = roverModel.rover?.name
        self.landingDateValue.text = roverModel.rover?.landingDate
        self.launchDateValue.text = roverModel.rover?.launchDate
        self.stasusValue.text = roverModel.rover?.status
        self.cameraNameValue.text = roverModel.camera?.name
        self.photodateValue.text = roverModel.earthDate
        self.martianSolValue.text = String(roverModel.sol ?? 0)
        
    }
    
    
    private func configure() {
        backgroundColor = .systemGray4
        layer.cornerRadius = 15
        
        
        let infoStackView = UIStackView(arrangedSubviews: [roverName, landingDate, launchDate, stasus, cameraName, photoDate, martianSol])
        infoStackView.axis = .vertical
        infoStackView.distribution = .fillEqually
        
        let valueStackView = UIStackView(arrangedSubviews: [roverNameValue, landingDateValue, launchDateValue, stasusValue, cameraNameValue, photodateValue, martianSolValue])
        
        valueStackView.axis = .vertical
        valueStackView.distribution = .fillEqually
        
        
        addSubview(infoStackView)
        addSubview(valueStackView)
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        valueStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            infoStackView.widthAnchor.constraint(equalToConstant: 130),
            infoStackView.heightAnchor.constraint(equalToConstant: 170),
            
            valueStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            valueStackView.leadingAnchor.constraint(equalTo: infoStackView.trailingAnchor, constant: 5),
            valueStackView.widthAnchor.constraint(equalToConstant: 130),
            valueStackView.heightAnchor.constraint(equalToConstant: 170),
        ])
        
        
    }

}
