//
//  OppourtunityViewController.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 17.12.2022.
//

import UIKit

final class OpportunityViewController: EMDataRequesterVC {

    //MARK: - Properties
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var filterCamButton: UIButton!
    @IBOutlet weak var emptyStateView: EMEmptyStateView!
    
    private var viewModel: RoverViewModel!
    
    
    init(viewModel: RoverViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        viewModel.requestNetworkCall()
    }
    
    
    //MARK: - Actions
    @objc func dateSelected() {
        viewModel.selectedDate = datePicker.date.inNasaFormat()
    }
    

    //MARK: - Configurations
    private func configureViewController() {
        titleLabel.text = "Opportunity"
        view.backgroundColor = .systemGray6
        viewModel.delegate = self
        configureCollectionView()
        setPopUpButton()
        configureDatePicker()
        emptyStateView.checkToDisplayforRover(viewModel: viewModel)
    }
    
    
    private func setPopUpButton() {
        let optionClosure = {(action : UIAction) in
            if action.title == "All Cameras" {
                self.viewModel.isMorePhotosAvailable = true
                self.viewModel.isFiltered = false
                self.viewModel.selectedCam = ""
            } else {
                self.viewModel.isFiltered = true
                self.viewModel.isMorePhotosAvailable = false
                self.viewModel.selectedCam = action.title
            }
        }
        
        filterCamButton.menu = UIMenu(children: [
            UIAction(title: "All Cameras", state: .on, handler: optionClosure),
            UIAction(title: "FHAZ", handler: optionClosure),
            UIAction(title: "RHAZ", handler: optionClosure),
            UIAction(title: "NAVCAM", handler: optionClosure),
            UIAction(title: "PANCAM", handler: optionClosure),
            UIAction(title: "MINITES", handler: optionClosure)
            
        ])
        filterCamButton.showsMenuAsPrimaryAction = true
        filterCamButton.changesSelectionAsPrimaryAction = true
    }

    
    private func configureDatePicker() {
        datePicker.tintColor = .orange
        datePicker.addTarget(self, action: #selector(dateSelected), for: .editingDidEnd)
    }
    
    
    private func configureCollectionView() {
        
        collectionView.collectionViewLayout = twoColumnFlowLayout(for: view)
        collectionView.register(UINib(nibName: RoverPhotoCell.reuseId, bundle: nil), forCellWithReuseIdentifier: RoverPhotoCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
        }
}


//MARK: - CollectionView Extension
extension OpportunityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.isFiltered ? viewModel.filteredRoverModel.count : viewModel.roverModel.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoverPhotoCell.reuseId, for: indexPath) as! RoverPhotoCell
        
        viewModel.isFiltered ? cell.set(with: viewModel.filteredRoverModel[indexPath.row]) : cell.set(with: viewModel.roverModel[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let roverModel = viewModel.roverModel[indexPath.row]
        let detailVC = DetailsViewController(roverModel: roverModel)
        
        self.present(detailVC, animated: true)
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y               // shows how much you scrolled down
        let contentHeight = scrollView.contentSize.height       // shows initial content height
        let height = scrollView.frame.size.height           // height of scrollview for current device
        
        
        if offsetY > contentHeight - height {
            guard viewModel.isMorePhotosAvailable, !viewModel.isLoadingMorePhotos else { return }
            viewModel.page += 1
            viewModel.requestNetworkCall()
            
        }
    }
}


//MARK: - Update Protocol
extension OpportunityViewController: UIUpdateProtocol {
    func didRecieveData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.emptyStateView.checkToDisplayforRover(viewModel: self.viewModel)
        }
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
