//
//  RmService.swift
//  Ricky
//
//  Created by Apple on 07/06/23.
//

import Foundation


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
    public func execute<T:Codable>(_ request: RmRequest, ExpectedType : T.Type, Completion : @escaping (Result<T,Error>) -> Void) {
        
    }
}
