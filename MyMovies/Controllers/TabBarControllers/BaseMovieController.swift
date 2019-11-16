//
//  BaseMovieController.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 11/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import UIKit

class BaseMovieController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let tabBarControlller = tabBarController as? MainTabBarController {
            tabBarControlller.setTabBarVisible(visible: true, animated: true)
        }
        
        // Reset navBar
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
}
