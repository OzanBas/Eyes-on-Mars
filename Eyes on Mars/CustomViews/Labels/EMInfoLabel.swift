//
//  EMInfoLabel.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 19.12.2022.
//

import UIKit

final class EMInfoLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    
    convenience init(title: String) {
        self.init()
        self.text = title
    }
    
    
    func configure() {
        font = .boldSystemFont(ofSize: 16)
        textAlignment = .left
        textColor = .label
    }
}
