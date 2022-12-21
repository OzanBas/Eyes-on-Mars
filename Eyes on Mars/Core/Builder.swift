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

        let curiosityVM = RoverViewModel(rover: Endpoints.curiosity, defaultDate: "2022-12-13")
        let curiosityVC = CuriosityViewController(viewModel: curiosityVM)
        curiosityVC.tabBarItem = UITabBarItem(title: "Curiosity", image: Images.curiosityLogo, tag: 0)
        
        let opportunityVM = RoverViewModel(rover: Endpoints.opportunity, defaultDate: "2018-05-10")
        let opportunityVC = OpportunityViewController(viewModel: opportunityVM)
        opportunityVC.tabBarItem = UITabBarItem(title: "Opportunity", image: Images.opportunityLogo, tag: 1)
        
        let spiritVM = RoverViewModel(rover: Endpoints.spirit, defaultDate: "2009-02-20")
        let spiritVC = SpiritViewController(viewModel: spiritVM)
        spiritVC.tabBarItem = UITabBarItem(title: "Spirit", image: Images.spiritLogo, tag: 2)
        
        let FavoritesVC = FavoritesViewController(viewModel: FavoritesViewModel())
        FavoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: Images.favorite, tag: 3)
        
        let viewControllers = [curiosityVC, opportunityVC, spiritVC, FavoritesVC]
        tabBar.viewControllers = viewControllers
        
        UITabBar.appearance().tintColor = .orange
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().backgroundColor = .black
        
        return tabBar
    }
}
