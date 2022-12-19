//
//  EMDiscriptionLabel.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 19.12.2022.
//

import UIKit

final class EMDiscriptionLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    
    func configure() {
        font = .systemFont(ofSize: 14)
        textColor = .secondaryLabel
        textAlignment = .left
    }
}
