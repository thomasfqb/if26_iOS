//
//  AppsSearchController.swift
//  AppStoreJSONApis
//
//  Created by Brian Voong on 2/8/19.
//  Copyright © 2019 Brian Voong. All rights reserved.
//

import UIKit
import SDWebImage

class MovieSearchController: BaseMovieController, UISearchBarDelegate {
    
    let cellId = "cellId"
    var result: Result?
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 18, left: 0, bottom: 18, right: 0)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.keyboardDismissMode = .interactive
        
        setupSearchBar()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return result?.movies.count ?? 0
       }
       
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieCell
           cell.movie = result?.movies[indexPath.item]
           return cell
       }
       
       override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           guard let result = result else { return }
           let movie = result.movies[indexPath.item]
           let movieController = MovieDetailController(for: movie)
           if let tabBarControlller = tabBarController as? MainTabBarController {
               tabBarControlller.setTabBarVisible(visible: false, animated: true)
           }
           navigationController?.pushViewController(movieController, animated: true)
       }
    
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let result = result else { return }
        if (indexPath.row == result.movies.count - 1 ) {
            //fetchMoreMovies
         }
    }
    
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
    }
    
    var timer: Timer?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            Service.shared.fetchMovies(searchTerm: searchText, page: 1) { (result, error) in
                if let error = error {
                    print("Search failed", error)
                    self.result = nil
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    return
                }
                
                guard let result = result else { return }
                self.result = result
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        })
    }
    
}

//MARK:- UICollectionViewDelegateFlowLayout

extension MovieSearchController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 18*2
        return .init(width: width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    
}



