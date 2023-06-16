//
//  RMImageManager.swift
//  Ricky
//
//  Created by Apple on 16/06/23.
//

import Foundation

final class RMImageManager {
    
    static let imageShared = RMImageManager()
    
    private init(){}

    private var imageDataCache = NSCache<NSString, NSData>()
    
    func downloadImage(url : URL, completion : @escaping(Result<Data,Error>) -> Void){
       
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key){
            completion(.success(data as Data))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else{
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            let value = data as NSData
            self.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
      }
    }
    

