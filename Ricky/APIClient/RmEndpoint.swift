//
//  RmEndpoint.swift
//  Ricky
//
//  Created by Apple on 07/06/23.
//

import Foundation


/// Represent unique Apis
@frozen enum RmEndpoint : String {
    
    /// Endpoint for  character info
    case character
    
    /// Endpoint for  episode info
    case episode
    
    /// Endpoint for  location info
    case location
}
