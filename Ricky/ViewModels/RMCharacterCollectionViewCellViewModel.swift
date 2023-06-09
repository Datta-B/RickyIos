//
//  RMCharacterCollectionViewCellViewModel.swift
//  Ricky
//
//  Created by Apple on 12/06/23.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel:Hashable,Equatable  {
    
    public  let characterName : String
    private let characterStatus : RMCharacterStatus
    private let characterImageUrl : URL?
    
    init(
        characterName : String,
        characterStatus : RMCharacterStatus,
        characterImageUrl : URL?
        
    ){
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    // MARK: - Hashable
    
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
    
    public var characterStatusText : String {
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(completion : @escaping(Result<Data,Error>)-> Void){
        
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageManager.imageShared.downloadImage(url: url, completion: completion)
        
        //
        //        let request = URLRequest(url: url)
        //
        //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        //            guard let data = data, error == nil else{
        //                completion(.failure(URLError(.badServerResponse)))
        //                return
        //            }
        //            completion(.success(data))
        //        }
        //        task.resume()
        //    }
    }
    
}
