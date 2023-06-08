//
//  RmRequest.swift
//  Ricky
//
//  Created by Apple on 07/06/23.
//

import Foundation

/// Request object
final class RmRequest {
    // base url
    // EndPoint
    // PathComponents
    // Query parameters
    
    // https://rickandmortyapi.com/api
    
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    private let endpoint : RmEndpoint
    
    private let pathComponents : Set<String>
    
    private let queryParameters : [URLQueryItem]
    
    
    /// Computed url
    private var urlString : String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach { str in
                string += "/\(str)"
            }
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumnetString = queryParameters.compactMap { str in
                guard let value = str.value else {return nil}
                return "\(str.name)=\(value)"
            }.joined(separator: "&")
            
            string += argumnetString
        }
         
        
        return string
    }
    
    public var url : URL? {
        return URL(string: urlString)
    }
    
    /// httpMethod type
    public let httpMethod = "Get"
    
    public init(endpoint: RmEndpoint, pathComponents: Set<String > = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
}
