//
//  CharacterListViewModel.swift
//  Ricky
//
//  Created by Apple on 10/06/23.
//

import Foundation
import UIKit


final class CharacterListViewModel : NSObject {
    
    func fetchCharacters(){
        RmService.shared.execute(.RMCharacterList, Expecting: RMGetAllCharacterResponse.self) { result in
            switch result {
            case .success(let model):
                print(String(describing: model))
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension CharacterListViewModel : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = .cyan
        
        return cell
        
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let bounds = UIScreen.main.bounds
        
        let width = (bounds.width - 30)/2
        
        let height = width*1.5
        
        return CGSize(width:width,height:height)

    }
    
    
}
