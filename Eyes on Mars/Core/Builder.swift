//
//  Builder.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 17.12.2022.
//

import UIKit

struct Builder {
    
    static func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()

        
        
        let curiosityVC = CuriosityViewController()
        curiosityVC.tabBarItem = UITabBarItem(title: "Curiosity", image: UIImage(systemName: "photo"), tag: 0)
        
        let opportunityVC = OpportunityViewController()
        opportunityVC.tabBarItem = UITabBarItem(title: "Opportunity", image: UIImage(systemName: "photo"), tag: 1)
        
        let spiritVC = SpiritViewController()
        spiritVC.tabBarItem = UITabBarItem(title: "Spirit", image: UIImage(systemName: "photo"), tag: 2)
        
        let FavoritesVC = OpportunityViewController()
        FavoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), tag: 3)
        
        let viewControllers = [curiosityVC, opportunityVC, spiritVC, FavoritesVC]
        tabBar.viewControllers = viewControllers
        
        UITabBar.appearance().tintColor = .red
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().backgroundColor = .black
        
        return tabBar
        
    }
}
