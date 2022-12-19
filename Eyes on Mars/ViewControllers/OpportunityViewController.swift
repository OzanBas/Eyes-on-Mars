//
//  OppourtunityViewController.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 17.12.2022.
//

import UIKit

class OpportunityViewController: UIViewController {

//MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var filterCamButton: UIButton!
    
    
    var viewModel: OpportunityViewModel!
    
    
    init(viewModel: OpportunityViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    func configureViewController() {
        titleLabel.text = "Opportunity"
        view.backgroundColor = .systemGray6
        viewModel.delegate = self
        configureCollectionView()
        setPopUpButton()
        configureDatePicker()
    }
    
    func setPopUpButton() {
        let optionClosure = {(action : UIAction) in
            self.viewModel.isMorePhotosAvailable = true
            print(action.title)
            if action.title == "All Cameras" {
                self.viewModel.selectedCam = ""
            } else {
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

    func configureDatePicker() {
        datePicker.tintColor = .orange
        datePicker.addTarget(self, action: #selector(dateSelected), for: .editingDidEnd)
    }
    
    func configureCollectionView() {
        
        collectionView.collectionViewLayout = twoColumnFlowLayout(for: view)
        collectionView.register(UINib(nibName: RoverPhotoCell.reuseId, bundle: nil), forCellWithReuseIdentifier: RoverPhotoCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
        }
    
}

//MARK: - CollectionView Extension
extension OpportunityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.roverModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoverPhotoCell.reuseId, for: indexPath) as! RoverPhotoCell
        
        cell.set(with: viewModel.roverModel[indexPath.row])
        
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
extension OpportunityViewController: viewModelProtocol {
    func updateData() {
        DispatchQueue.main.async { self.collectionView.reloadData() }
    }
    
    
}
