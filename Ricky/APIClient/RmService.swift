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
    ///   - Completion: Callback with data or error
    public func execute(_ request: RmRequest, Completion : @escaping () -> Void) {
        
    }
}
