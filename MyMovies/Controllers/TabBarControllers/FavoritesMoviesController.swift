//
//  FavoritesController.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 10/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import UIKit

class FavoritesMoviesController: UICollectionViewController {
    
    let cellId = "cellId"
    let spacing: CGFloat = 12
    
    var result: Result?
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchUpComingMovies()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let tabBarControlller = tabBarController as? MainTabBarController {
            tabBarControlller.setTabBarVisible(visible: true, animated: true)
        }
        
        // Reset navBar
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    //MARK:- Collection View
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: spacing, left: spacing, bottom: spacing, right: spacing)
        collectionView.register(FavoriteMovieCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result?.movies.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FavoriteMovieCell
        cell.movie = result?.movies[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let movie = result?.movies[indexPath.row] else { return }
        let movieDetailController = MovieDetailController(for: movie)
        navigationController?.pushViewController(movieDetailController, animated: true)
        
        if let tabBarController = tabBarController as? MainTabBarController {
            tabBarController.setTabBarVisible(visible: false, animated: true)
        }
        
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
    
    fileprivate func fetchUpComingMovies() {
        Service.shared.fetchUpcomingMovies { (result, error) in
            if let error = error {
                print("Failed to fetch upcoming movies", error)
                return
            }
            guard let result = result else { return }
            self.result = result
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

//MARK:- UICollectionViewDelegateFlowLayout

extension FavoritesMoviesController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = view.frame.width/2 - 2*spacing
        let height = 3*width/2
        
        return .init(width: width, height: height)
    }
    
}
