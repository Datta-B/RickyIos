//
//  DetailCharacterListViewViewController.swift
//  Ricky
//
//  Created by Apple on 13/06/23.
//

import UIKit

class DetailCharacterListViewViewController: UIViewController {

    private var viewModel : RMCharacterDetailViewModel
    
    init(viewModel: RMCharacterDetailViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title
    }
    

}
