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
    
    
    
    var user: User? {
        
        didSet {
            guard let user = user else {return}
            configureViewControllers(withUser: user)
            
        }
        
    }
    
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
//        authenticateUserAndConfigureUI()
        
        configureUI()
        
        if UserDefaults.standard.bool(forKey: "isLogin") == false {
            checkIfUserLoggedIn()
            fetcUser()
            
        } else {
            configureViewControllers2()
        }
        
        
        
        UITabBar.appearance().tintColor = .clubYellow
        
        navigationController?.navigationBar.isHidden = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI()
        
        if UserDefaults.standard.bool(forKey: "isLogin") == false {
            checkIfUserLoggedIn()
            fetcUser()
            
        } else {
            configureViewControllers2()
        }
    }
    
   
    
    // MARK: - API
    
    func fetcUser() {
        UserService.fetchUser { user in
            self.user = user
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Failed sign out")
        }
    }
    
    func checkIfUserLoggedIn() {
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = FTLoginScreenViewController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
            
        }
        
       
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    func configureUI() {
        self.delegate = self
        tabBar.isTranslucent = false
        
        switch traitCollection.userInterfaceStyle {
        case .dark:
            print("Dark")
            tabBar.backgroundColor = .black
            view.backgroundColor = .black
            
        case .light:
            print("Light")
            tabBar.backgroundColor = .white
            view.backgroundColor = .white
        default:
            print("something else")
        }
        
        
    }
    
    func configureViewControllers(withUser user: User) {
        
        
        
        if UserDefaults.standard.bool(forKey: "isLogin") == false {
            let blog = FTBlogScreenViewController()
            let nav1 = templateNavigationController(image: UIImage(systemName: "newspaper.fill"), title: "Blog", rootViewController: blog)
            
            let events = FTEventsScreenViewController()
            let nav2 = templateNavigationController(image: UIImage(systemName: "calendar.badge.clock"), title: "Etkinlikler", rootViewController: events)
            
            let main = FTMainScreenViewController()
            let nav3 = templateNavigationController(image: UIImage(systemName: "house.fill"), title: "Ana Sayfa", rootViewController: main)
            
            let profile = FTProfileScreenViewController(user: user)
            let nav4 = templateNavigationController(image: UIImage(systemName: "person.fill"), title: "Profil", rootViewController: profile)
            
            let extras = FTExtrasScreenViewController()
            let nav5 = templateNavigationController(image: UIImage(systemName: "increase.indent"), title: "Daha Fazla", rootViewController: extras)
            
            viewControllers = [nav1, nav2, nav3, nav4, nav5]
            
        } else {
            
            let blog = FTBlogScreenViewController()
            let nav1 = templateNavigationController(image: UIImage(systemName: "newspaper.fill"), title: "Blog", rootViewController: blog)
            
            let events = FTEventsScreenViewController()
            let nav2 = templateNavigationController(image: UIImage(systemName: "calendar.badge.clock"), title: "Etkinlikler", rootViewController: events)
            
            let main = FTMainScreenViewController()
            let nav3 = templateNavigationController(image: UIImage(systemName: "house.fill"), title: "Ana Sayfa", rootViewController: main)
            
            let extras = FTExtrasScreenViewController()
            let nav5 = templateNavigationController(image: UIImage(systemName: "increase.indent"), title: "Daha Fazla", rootViewController: extras)
            
            viewControllers = [nav1, nav2, nav3, nav5]
            
        }

        
        
    }
    
    func configureViewControllers2() {
        
            
            let blog = FTBlogScreenViewController()
            let nav1 = templateNavigationController(image: UIImage(systemName: "newspaper.fill"), title: "Blog", rootViewController: blog)
            
            let events = FTEventsScreenViewController()
            let nav2 = templateNavigationController(image: UIImage(systemName: "calendar.badge.clock"), title: "Etkinlikler", rootViewController: events)
            
            let main = FTMainScreenViewController()
            let nav3 = templateNavigationController(image: UIImage(systemName: "house.fill"), title: "Ana Sayfa", rootViewController: main)
            
            let extras = FTExtrasScreenViewController()
            let nav5 = templateNavigationController(image: UIImage(systemName: "increase.indent"), title: "Daha Fazla", rootViewController: extras)
            
            viewControllers = [nav1, nav2, nav3, nav5]
            
        

        
        
    }
    
    func templateNavigationController(image: UIImage?, title: String, rootViewController: UIViewController) -> UINavigationController {
        let nav = DarkModeAwareNavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        return nav
    }
}

extension FTMainTabBarControllerViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}

class DarkModeAwareNavigationController: UINavigationController {

  override init(rootViewController: UIViewController) {
       super.init(rootViewController: rootViewController)
       self.updateBarTintColor()
  }

  required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       self.updateBarTintColor()
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       super.traitCollectionDidChange(previousTraitCollection)
       self.updateBarTintColor()
  }

  private func updateBarTintColor() {
       if #available(iOS 13.0, *) {
            self.navigationBar.barTintColor = UITraitCollection.current.userInterfaceStyle == .dark ? .black : .white
  }
  }
}

extension FTMainTabBarControllerViewController: AuthenticationDelegate {
    func authenticationDidComplete() {
        print("Debug: Auth did complete. User updated")
        fetcUser()
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
