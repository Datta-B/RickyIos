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
    
    private let pathComponents : [String]
    
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
    
    public init(endpoint: RmEndpoint, pathComponents: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    convenience init?(url:URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/"){
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endPointStr = components[0]
                var pathComponts : [String] = []
                if components.count > 1{
                    pathComponts = components
                    pathComponts.removeFirst()
                }
                if let rmEndPoint = RmEndpoint(rawValue: endPointStr){
                    self.init(endpoint: rmEndPoint,pathComponents: pathComponts)
                    return
                }
            }
        }else if trimmed.contains("?"){
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2{
                let endPointStr = components[0]
                let queryItemString = components[1]
                let queryItems : [URLQueryItem] = queryItemString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else{
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(name: parts[0], value: parts[1])
                })
                if let rmEndPoint = RmEndpoint(rawValue: endPointStr){
                    self.init(endpoint: rmEndPoint,queryParameters: queryItems)
                    return
                }
            }

        }
        return nil
    }
}

extension RmRequest {
    static let RMCharacterList = RmRequest(endpoint: .character)
}
