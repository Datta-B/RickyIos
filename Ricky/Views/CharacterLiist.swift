//
//  CharacterLiist.swift
//  Ricky
//
//  Created by Apple on 10/06/23.
//

import UIKit

protocol RMCharacterListViewDelegate : AnyObject {
    func rmCharacterListView(_ characterListView:CharacterLiist, didSelectCharacter:RMCharacter)
}

/// View Shows CharacterList with loader
final class CharacterLiist: UIView {
   
    public weak var delegate : RMCharacterListViewDelegate?
    private let viewModel = CharacterListViewModel()
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero,collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        cv.isHidden = true
        cv.alpha = 0
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
        
        cv.register(RMFooterLoaderCollectionReusableView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                    withReuseIdentifier: RMFooterLoaderCollectionReusableView.cellIdentifier)
        
        
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBlue
        addConstraints()
        setUpCollectionView()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchCharacters()
//        addSubviews(collectionView,spinner)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addConstraints(){
        addSubview(collectionView)
        addSubview(spinner)
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
    
    private func setUpCollectionView(){
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        
    }
}


extension CharacterLiist : RMCharacterListViewModelDelegate {
    
    func didSelectCharacter(_ character: RMCharacter) {
        delegate?.rmCharacterListView(self, didSelectCharacter: character)
    }
    
    func loadCharacterCV() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.stopAnimating()
            self?.collectionView.isHidden = false
            self?.collectionView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self?.collectionView.alpha = 1
            }
        }
    }
}
