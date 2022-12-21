//
//  FavoritesViewController.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 17.12.2022.
//

import UIKit

final class FavoritesViewController: EMDataRequesterVC {

    //MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: FavoritesViewModel!
    
    
    init(viewModel: FavoritesViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.loadFavorites()
    }

   
    //MARK: - Configuration
    private func configureViewController() {
        view.backgroundColor = .systemGray6
        titleLabel.text = "Favorites"
        viewModel.delegate = self
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: FavoritesCell.reuseId, bundle: nil), forCellReuseIdentifier: FavoritesCell.reuseId)
        tableView.rowHeight = 110
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
}

//MARK: - TableView Extension
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.roverModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseId, for: indexPath) as! FavoritesCell
        
        cell.set(roverModel: viewModel.roverModel[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = viewModel.roverModel[indexPath.row]
        
        PersistenceManager.update(favorite: favorite) { [weak self] error in
            guard self != nil else { return }
            
        }
        self.viewModel.loadFavorites()
    }
}

//MARK: - UIUpdateProtocol
extension FavoritesViewController: UIUpdateProtocol {
    func didRecieveData() {
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    func didRecieveError(error: EMError) {
        self.presentEMAlertOnMainThread(title: "Error", message: error.rawValue, buttonText: "Ok")
    }
    
    func willStartLoading() {
        showActivityIndicator()
    }
    
    func didFinishLoading() {
        dismissActivityIndicator()
    }
}
