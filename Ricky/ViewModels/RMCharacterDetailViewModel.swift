//
//  RMCharacterDetailViewModel.swift
//  Ricky
//
//  Created by Apple on 13/06/23.
//

import Foundation

final class RMCharacterDetailViewModel {
    
    private let character:RMCharacter
    
    init(character:RMCharacter){
        self.character = character
    }
    
    public var title : String {
        return character.name.uppercased()
    }
}
