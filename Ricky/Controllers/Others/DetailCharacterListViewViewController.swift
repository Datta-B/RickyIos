//
//  DetailCharacterListViewViewController.swift
//  Ricky
//
//  Created by Apple on 13/06/23.
//

import UIKit

class DetailCharacterListViewViewController: UIViewController {

    private let detailView : RMCharacterDetailsView
    
    private var viewModel : RMCharacterDetailViewModel
    
    init(viewModel: RMCharacterDetailViewModel){
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailsView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        view.addSubview(detailView)
        detailView.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        //viewModel.fetchCharacterData()
    
        addConstraints()

        detailView.collectionVC?.delegate = self
        detailView.collectionVC?.dataSource = self
        
    }
    
    @objc func didTapShare(){
        
    }
    
    private func addConstraints(){
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }
    

}
// MARK:- CollectionView Delegate Methods

extension DetailCharacterListViewViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let sectionType = viewModel.sections[section]
        
        switch sectionType {
        case .photo:
            return 1
        case .information(viewModel: let viewModel):
            return viewModel.count
        case .episodes(viewModel: let viewModel):
            print(viewModel.count)
            return viewModel.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = viewModel.sections[indexPath.section]
        
        switch section {
            
        case .photo(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RMCharacterPhotoCollectionViewCell", for: indexPath) as? RMCharacterPhotoCollectionViewCell else {
                fatalError()
            }
            
            cell.configure(with: viewModel)
            return cell

        case .information(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RMCharacterInfoCollectionViewCell", for: indexPath) as? RMCharacterInfoCollectionViewCell else {
                fatalError()
            }
            
            cell.configure(with: viewModel[indexPath.row])

            return cell

        case .episodes(viewModel: let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterEpisodeCollectionViewCell else {
                fatalError()
            }
            
            cell.configure(with: viewModel[indexPath.row])
            
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let section = viewModel.sections[indexPath.section]
        switch section {
            
        case .photo,.information :
            
            break
            
        case .episodes:
            let episode = self.viewModel.episdoes
            let selection = episode[indexPath.row]
            guard let selectedUrl = URL(string:selection) else{return}
            let vc = EpisodesDetailsViewController(url: selectedUrl)
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    
}
