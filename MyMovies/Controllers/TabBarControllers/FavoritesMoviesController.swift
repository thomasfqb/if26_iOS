//
//  FavoritesController.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 10/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import UIKit

class FavoritesMoviesController: BaseMovieController {
    
    let cellId = "cellId"
    let spacing: CGFloat = 12
    
    var movies = [Movie]() {
        didSet {
            emptyCollectionLabel.alpha = movies.count > 0 ? 0 : 1
        }
    }
    
    let emptyCollectionLabel = UILabel(text: "😕\nPas encore de films ajoutés aux favoris...", font: .boldSystemFont(ofSize: 22), numberOfLines: 0, textColor: .lightGray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupLayout()
        
    }
    
    fileprivate func setupLayout() {
        emptyCollectionLabel.textAlignment = .center
        view.addSubview(emptyCollectionLabel)
        emptyCollectionLabel.centerInSuperview(size: .init(width: view.frame.width - 44, height: 0))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchFavoritesMovies()
    }
    
    //MARK:- Collection View
    
    fileprivate func setupCollectionView() {
           collectionView.backgroundColor = .white
           collectionView.contentInset = .init(top: spacing, left: spacing, bottom: spacing, right: spacing)
           collectionView.register(FavoriteMovieCell.self, forCellWithReuseIdentifier: cellId)
       }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
        
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FavoriteMovieCell
        cell.movie = movies[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.item]
        let movieController = MovieDetailController(for: movie)
        if let tabBarControlller = tabBarController as? MainTabBarController {
            tabBarControlller.setTabBarVisible(visible: false, animated: true)
        }
        navigationController?.pushViewController(movieController, animated: true)
    }
        
    fileprivate func fetchFavoritesMovies() {
        //Fix for last element staying in CV
        self.movies.removeAll()
        self.collectionView.reloadData()
        
        Database.shared.getFavoritesMovies { (movies, error) in
            if let error = error {
                print("Failed to fecth favorites", error)
                return
            }
            guard let movies = movies else { return }
            self.movies = movies
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
