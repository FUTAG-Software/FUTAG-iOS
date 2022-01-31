//
//  FTMainTabBarControllerViewController.swift
//  Futag
//
//  Created by Furkan Erdoğan on 9.01.2022.
//

import UIKit
import Firebase


class FTMainTabBarControllerViewController: UITabBarController {
    
    // MARK: - Properties
    
    var user: User?
    
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        authenticateUserAndConfigureUI()
        
        configureViewControllers()
    }
    
    // MARK: - API
    
    func fetchUser() {
       
    }
    
    func authenticateUserAndConfigureUI() {
       
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    func configureUI() {
        self.delegate = self
        
    }
    
    func configureViewControllers() {
        
        let blog = FTBlogScreenViewController()
        let nav1 = templateNavigationController(image: UIImage(systemName: "newspaper"), title: "Blog", rootViewController: blog)
        
        let events = FTEventsScreenViewController()
        let nav2 = templateNavigationController(image: UIImage(systemName: "calendar.badge.clock"), title: "Etkinlikler", rootViewController: events)
        
        let main = FTMainScreenViewController()
        let nav3 = templateNavigationController(image: UIImage(systemName: "house.fill"), title: "Ana Sayfa", rootViewController: main)

        let profile = FTProfileScreenViewController()
        let nav4 = templateNavigationController(image: UIImage(systemName: "person.fill"), title: "Profil", rootViewController: profile)
        
        let extras = FTExtrasScreenViewController()
        let nav5 = templateNavigationController(image: UIImage(systemName: "increase.indent"), title: "Daha Fazla", rootViewController: extras)
        
        viewControllers = [nav1, nav2, nav3, nav4, nav5]
    }
    
    func templateNavigationController(image: UIImage?, title: String, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        nav.navigationBar.barTintColor = .white
        return nav
    }
}

extension FTMainTabBarControllerViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
