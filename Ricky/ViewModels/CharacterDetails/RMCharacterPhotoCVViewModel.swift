//
//  RMCharacterPhotoViewModel.swift
//  Ricky
//
//  Created by Apple on 20/06/23.
//

import Foundation
import UIKit

final class RMCharacterPhotoCollectionCellViewModel {
    private let imageUrl : URL?
    
    init(imageUrl:URL){
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(Completion : @escaping(Result<Data,Error>) -> ()){
        guard let url = imageUrl else {
            Completion(.failure(URLError(.badURL)))
            return
        }
        RMImageManager.imageShared.downloadImage(url: url, completion: Completion)
    }
//    func fetchImage(completion: @escaping (UIImage?) -> Void) {
//        guard let url = imageUrl else {fatalError("unSupported URL")}
//        RMImageManager.imageShared.downloadImage(url: url) { result in
//            switch result {
//            case .success(let data):
//                let imageData = UIImage(data: data)
//              completion(imageData)
//            case .failure(let error):
//                print("Error:\(error)")
//            }
//        }
//    }
//
}
