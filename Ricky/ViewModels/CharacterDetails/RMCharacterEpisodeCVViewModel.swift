//
//  RMCharacterEpisodeViewModel.swift
//  Ricky
//
//  Created by Apple on 20/06/23.
//

import Foundation

protocol RMEpisodesDataRender {
    var name : String {get}
    var air_date : String {get}
    var episode : String {get}

}


final class RMCharacterEpisodeCollectionCellViewModel {

    private let CharacterEpisodeURL : URL?
    
    private var isFetching : Bool = false
    
    private var episode : RMEpisode? {
        didSet {
            guard let model = episode else{
                return
            }
            block?(model)
        }
    }
    
    private var block : ((RMEpisodesDataRender)-> Void)?
    
    init(CharacterEpisodeURL:URL){
        self.CharacterEpisodeURL = CharacterEpisodeURL
    }
    
    public func registerForData(_ block : @escaping(RMEpisodesDataRender)-> Void){
        self.block = block
    }
    
    public func fetchEpisode(){
        
        guard !isFetching else {
            if let model = episode {
                block?(model)
            }
            return
        }

        guard let url = CharacterEpisodeURL, let rmRequest = RmRequest(url: url) else{
            return 
        }
        
        isFetching = true
        
        RmService.shared.execute(rmRequest, Expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
