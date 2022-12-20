//
//  FavoritesViewController.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 17.12.2022.
//

import UIKit

class FavoritesViewController: UIViewController {

//MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
 
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

//MARK: - Actions

    
//MARK: - Configuration
    func configure() {
        view.backgroundColor = .systemGray6
        titleLabel.text = "Favorites"
    }
    
}
