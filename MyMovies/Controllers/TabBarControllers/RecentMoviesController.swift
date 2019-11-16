//
//  RecentMoviesController.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 10/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import UIKit

class RecentMoviesController: BaseMovieController {
        
    let cellId = "cellId"
    
    var result: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchUpComingMovies()
    }
    
    //MARK:- Collection View
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 18, left: 0, bottom: 18, right: 0)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: cellId)
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
            fetchMoreMovies()
         }
    }
    
    
    //MARK:- API Calls
    
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
    
    
    fileprivate func fetchMoreMovies() {
        guard let result = result else { return }
        let page = result.page + 1
        Service.shared.fetchUpcomingMovies(page: page) { (result, error) in
            if let error = error {
                print("Failed to fetch upcoming movies", error)
                return
            }
            
            guard let result = result else { return }
            self.result?.movies.append(contentsOf: result.movies)
            self.result?.page = page
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}

//MARK:- UICollectionViewDelegateFlowLayout

extension RecentMoviesController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 18*2
        return .init(width: width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
}
