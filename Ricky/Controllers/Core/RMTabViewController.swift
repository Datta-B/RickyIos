//
//  ViewController.swift
//  Ricky
//
//  Created by Apple on 07/06/23.
//

import UIKit

final class RMTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setUpTabs()
    }
    
    private func setUpTabs(){
        
        let characterVC = RmCharacterViewController()
        let LocationVC = RMLocationViewController()
        let episodeVC = RMEpisodesViewController()
        let settingsVC = RMSettingsViewController()


        characterVC.title = "Character"
        LocationVC.title = "Location"
        episodeVC.title = "Episode"
        settingsVC.title = "Setting"

        for i in 0..<4{
            switch i{
            case 0:
                updateTitle(vc: characterVC)
            case 1:
                updateTitle(vc: LocationVC)
            case 2:
                updateTitle(vc: episodeVC)
            case 3:
                updateTitle(vc: settingsVC)
                
            default : break
                
            }}

        let nav1 = UINavigationController(rootViewController: characterVC)
        let nav2 = UINavigationController(rootViewController: LocationVC)
        let nav3 = UINavigationController(rootViewController: episodeVC)
        let nav4 = UINavigationController(rootViewController: settingsVC)

        nav1.tabBarItem = UITabBarItem(title: "Character", image: UIImage(systemName: "person") , tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Location", image:UIImage(systemName: "globe") , tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Episode", image:UIImage(systemName: "tv") , tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "gear"), tag: 4)

        
        for nav in [nav1,nav2,nav3,nav4] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1,nav2,nav3,nav4], animated: true)
        
    }

    private func updateTitle(vc:UIViewController){
        navigationItem.largeTitleDisplayMode = .automatic

    }

}

