//
//  EpisodesDetailsViewController.swift
//  Ricky
//
//  Created by Apple on 26/06/23.
//

import UIKit

class EpisodesDetailsViewController: UIViewController {

    private let url : URL?
    
    init(url : URL){
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder:NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "episode".uppercased()
        view.backgroundColor = .systemGray
    }


}
