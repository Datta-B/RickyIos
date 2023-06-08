//
//  RMCharacter.swift
//  Ricky
//
//  Created by Apple on 07/06/23.
//

import Foundation

struct RMCharacter : Codable {
    
    let id : Int
    let name: String
    let status: RMCharacterStatus
    let species : String
    let type : String
    let gender : RmCharacterGender
    let origin: RMOrigin
    let location: SingleLocation
    let image: String
    let episode: [ String]
    let url: String
    let created: String
    
}

struct RMOrigin : Codable {
    let name: String
    let url: String
    
}

struct SingleLocation : Codable {
    let name: String
    let url: String
}

enum RMCharacterStatus : String,Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum RmCharacterGender : String,Codable {
     case male = "Male"
     case female = "Female"
     case genderless = "Genderless"
     case unknown = "unknow"
    
}
