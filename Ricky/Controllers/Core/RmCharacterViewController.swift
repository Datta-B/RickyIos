//
//  RmCharacterViewController.swift
//  Ricky
//
//  Created by Apple on 07/06/23.
//

import UIKit


/// Character Vc
final class RmCharacterViewController: UIViewController, RMCharacterListViewDelegate {
  
    
    private let characterListView = CharacterLiist()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(characterListView)
        characterListView.delegate = self
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
        
    }
    
    // Delegate Function
    
    func rmCharacterListView(_ characterListView: CharacterLiist, didSelectCharacter: RMCharacter) {
        
        let viewModel = RMCharacterDetailViewModel(character:didSelectCharacter)
        let vc = DetailCharacterListViewViewController(viewModel: viewModel)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: false)
        
    }
    
    
    
}
