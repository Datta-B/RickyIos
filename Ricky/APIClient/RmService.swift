//
//  RmService.swift
//  Ricky
//
//  Created by Apple on 07/06/23.
//

import Foundation

enum RMServiceError : Error {
    case faileToRequest
    case failedResponse
}

///  Primary Api Service object
final class RmService {
    
    /// Shared signleton instance
    static let shared = RmService()
    
    /// Privatized constructor
    private init(){}
    
    
    /// Send Rikcy Api Call
    /// - Parameters:
    ///   - request: request
    ///   - type : expected Type
    ///   - Completion: Callback with data or error
    public func execute<T:Codable>(_ request: RmRequest, Expecting type : T.Type, Completion : @escaping (Result<T,Error>) -> Void) {
        
        guard let urlRequest = self.request(from: request) else {
            Completion(.failure(RMServiceError.faileToRequest))
              return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data ,error == nil else {
                Completion(.failure(error ?? RMServiceError.failedResponse))
                return
            }
            do{
//                let json = try JSONSerialization.jsonObject(with: data)
//                print(String(describing: json))
                let result = try JSONDecoder().decode(type.self, from: data)
                Completion(.success(result))

            }catch (let error) {
                Completion(.failure(error))
                
            }
        
        }
        task.resume()
    }
    
    // MARK: - Private
    
    private func request(from rmRequest : RmRequest) -> URLRequest? {
        guard let url = rmRequest.url else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}
