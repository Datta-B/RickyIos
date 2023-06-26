//
//  RMCharacterDetailViewModel.swift
//  Ricky
//
//  Created by Apple on 13/06/23.
//

import Foundation
import UIKit

final class RMCharacterDetailViewModel {
    
    private let character:RMCharacter
    
    public var episdoes : [String]{
        character.episode
    }
    
    enum SectionType  {
        
        case photo(viewModel : RMCharacterPhotoCollectionCellViewModel)
        
        case information(viewModel : [RMCharacterInfoCollectionCellViewModel])
        
        case episodes(viewModel : [RMCharacterEpisodeCollectionCellViewModel])
    }
    
    init(character:RMCharacter){
        self.character = character
        setUpSectionType()
    }

    private func setUpSectionType(){
        guard let imageUrl = URL(string: character.image) else {return}

        sections = [
            .photo(viewModel:.init(imageUrl: imageUrl)),
            .information(viewModel: [
                .init(type: .status , value: character.status.text),
                .init(type: .gender , value: character.gender.rawValue),
                .init(type: .type , value: character.type),
                .init(type: .species , value: character.species),
                .init(type: .origin , value: character.origin.name),
                .init(type: .location , value: character.location.name),
                .init(type: .created , value: character.created),
                .init(type: .episodeCount , value: "\(character.episode.count)"),
            ]),
            .episodes(viewModel: character.episode.compactMap ({ url in
                URL(string: url).map { RMCharacterEpisodeCollectionCellViewModel(CharacterEpisodeURL: $0) }
            }))
//            .episodes(viewModel: character.episode.compactMap({
//                RMCharacterEpisodeCollectionCellViewModel(CharacterEpisodeURL: URL(string: $0)!)
//            }))
//            .episodes(viewModel: character.episode.compactMap({ str in
//                guard let str = str else {return}
//                    .RMCharacterEpisodeCollectionCellViewModel(CharacterEpisodeURL: URL(string: str))
//            }))
        ]
    }
    
    public var title : String {
        return character.name.uppercased()
    }
    
    public var requestUrl : URL? {
        return URL(string: character.url)
    }
    
    public var sections:[SectionType] = []
    
    // Layouts
    
   public func createPhotoLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
   
    public func createInformationLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150)), subitems: [item,item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    public func createEpisodesLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(150)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }


    
}
