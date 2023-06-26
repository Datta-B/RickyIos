//
//  RMCharacterDetailView.swift
//  Ricky
//
//  Created by Apple on 13/06/23.
//

import Foundation
import UIKit


final class RMCharacterDetailsView : UIView {
    
    public var collectionVC : UICollectionView?
   
    private var viewModel : RMCharacterDetailViewModel?
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    
    init(frame: CGRect,viewModel : RMCharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        let collectionVC = createCollecetionView()
        self.collectionVC = collectionVC
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints(){
        guard let collectionView = collectionVC else {return}
        addSubviews(spinner,collectionView)
        NSLayoutConstraint.activate([
            
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
        
    }
    
    private func createCollecetionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RMCharacterPhotoCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier)
        collectionView.register(RMCharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier)
        collectionView.register(RMCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier)

        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    private func createSection(for sectionIndex : Int) -> NSCollectionLayoutSection{
        
        let sectionTypes = viewModel?.sections
        
        guard let photo = viewModel?.createPhotoLayout() else {
            fatalError("error")
        }
        guard let info = viewModel?.createInformationLayout() else {
            fatalError("error")
        }
        guard let episode = viewModel?.createEpisodesLayout() else {
            fatalError("error")
        }

        switch sectionTypes![sectionIndex] {
            
        case .photo:
            return photo
        case .information:
            return info
        case .episodes:
            return episode
        }
        

    }
    
 
}
