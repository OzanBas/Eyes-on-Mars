//
//  UIHelpers.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 17.12.2022.
//

import UIKit


func twoColumnFlowLayout(for view: UIView) -> UICollectionViewFlowLayout {
    let width = view.bounds.width
    let padding: CGFloat = 12
    let itemSpacing: CGFloat = 10
    let availableWidth = width - (padding * 2) - itemSpacing
    let cellWidth = availableWidth / 2
    
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth - 85)
    return flowLayout
}
