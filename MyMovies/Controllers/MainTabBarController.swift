//
//  MainTabBarController.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 10/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewControllers = [
            templateNavController(title: "Récents", image: #imageLiteral(resourceName: "list"), rootViewController: RecentMoviesController()),
            templateNavController(title: "Favoris", image: #imageLiteral(resourceName: "favorite"), rootViewController: FavoritesMoviesController()),
            templateNavController(title: "Recherche", image: #imageLiteral(resourceName: "search"), rootViewController: MovieSearchController())
        ]
    }
    
    
    fileprivate func templateNavController(title: String, image: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = image
        viewController.title = title
        return navController
    }
    
    

    //MARK:- TabBar animation
    
    func setTabBarVisible(visible: Bool, animated: Bool, completion: ((Bool)->Void)? = nil ) {
        // bail if the current state matches the desired state
        if (tabBarIsVisible() == visible) {
            if let completion = completion {
                return completion(true)
            }
            else {
                return
            }
        }

        // get a frame calculation ready
        let height = self.tabBar.frame.size.height
        let offsetY = (visible ? -height : height)

        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            let frame = self.tabBar.frame
            self.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)

        }, completion: completion)

    }
    
    func tabBarIsVisible() -> Bool {
        return self.tabBar.frame.origin.y < view.frame.maxY
    }
    
    
}

