//
//  EMButton.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 18.12.2022.
//

import UIKit

final class EMFilterButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    
    private func configure() {
        backgroundColor = .orange
        setTitle("Cam Filter", for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        layer.cornerRadius = 10
    }
}
