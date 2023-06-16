//
//  CharacterListViewModel.swift
//  Ricky
//
//  Created by Apple on 10/06/23.
//

import Foundation
import UIKit

protocol RMCharacterListViewModelDelegate: AnyObject{
    func loadCharacterCV()
    func didSelectCharacter(_ character:RMCharacter)
}

final class CharacterListViewModel : NSObject {
    
    public weak var delegate : RMCharacterListViewModelDelegate?
    
    private var characters:[RMCharacter] = [] {
        didSet{
            for each in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(characterName: each.name, characterStatus: each.status, characterImageUrl: URL(string:each.image))
                
                if !collectionViewModels.contains(viewModel) {
                    collectionViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var collectionViewModels : [RMCharacterCollectionViewCellViewModel] = []
    private var apiInfo : RMGetAllCharacterResponse.Info? = nil
    private var isLoadingMoreCharacter = false
    
    public func fetchCharacters(){
        RmService.shared.execute(.RMCharacterList, Expecting: RMGetAllCharacterResponse.self) { result in
            switch result {
            case .success(let responseModel):
                self.characters = responseModel.results
                let info = responseModel.info
                self.apiInfo = info
                DispatchQueue.main.async {
                    self.delegate?.loadCharacterCV()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // More Characters
    public func fetchAdditionalCharacter(url : URL){
        
        guard !isLoadingMoreCharacter else {return}
        
        isLoadingMoreCharacter = true
        
        guard let request = RmRequest(url: url) else {isLoadingMoreCharacter = false
            return }
        
        RmService.shared.execute(request, Expecting: RMGetAllCharacterResponse.self) { result in
            switch result {
            case .success(let result):
                self.characters.append(contentsOf: result.results)
                let info = result.info
                self.apiInfo = info
                DispatchQueue.main.async {
                    self.delegate?.loadCharacterCV()
                    self.isLoadingMoreCharacter = false
                }

            case .failure(let error):
                print(error)
            }
        }
        
    }
    // Show Loader
    public var shouldLoader : Bool {
        return apiInfo?.next != nil
    }

}

// MARK:- CollectionView Deleagat Methods

extension CharacterListViewModel : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterCollectionViewCell else{
            fatalError("UnSupported cell")
        }
        
        let viewModel = collectionViewModels[indexPath.row]
        
        cell.configure(with: viewModel)
        
        return cell
        
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let bounds = UIScreen.main.bounds
        
        let width = (bounds.width - 30)/2
        
        let height = width*1.5
        
        return CGSize(width:width,height:height)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let character =  characters[indexPath.row]
        
        delegate?.didSelectCharacter(character)
        
    }
    
    // DATA SOURCE
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionFooter else {
             fatalError("UnSupported")
        }
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RMFooterLoaderCollectionReusableView.cellIdentifier, for: indexPath) as?  RMFooterLoaderCollectionReusableView
        
        footer?.startAnimation()
        
        return footer!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldLoader else{
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

extension CharacterListViewModel : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldLoader,
        !isLoadingMoreCharacter,
        !collectionViewModels.isEmpty,
        let urlNext = apiInfo?.next,
        let url = URL(string: urlNext)
        else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120){
                self?.fetchAdditionalCharacter(url: url)
            }
            t.invalidate()
        }
    
    }
}
