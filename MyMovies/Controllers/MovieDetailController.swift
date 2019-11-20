//
//  MovieController.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 10/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import UIKit

class MovieDetailController: UICollectionViewController {
    
    var movie: Movie
    
    init(for movie: Movie) {
        self.movie = movie
        super.init(collectionViewLayout: StretchyHeaderLayout())
        fetchVideos()
    }
    
    let headerId = "headerId"
    let overviewCellId = "overviewCellId"
    let trailerCellId = "trailerCellId"
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
    }
    
    fileprivate func fetchVideos() {
        Service.shared.fetchVideos(for: movie) { (result, error) in
            if let error = error {
                print("Failed to fetch videos for movie", error)
                return
            }
            
            guard let result = result else { return }
            self.movie.videos = result.results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK:- Nav bar
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        //Make the navigation bar transparent
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.tintColor = .white
        
        let isFavorite = Database.shared.movieIsFavorite(movie)
        let favoriteButton = UIBarButtonItem(image: isFavorite ? #imageLiteral(resourceName: "favorite_filled") : #imageLiteral(resourceName: "favorite"), style: .plain, target: self, action: #selector(handleUpdateLike))
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc fileprivate func handleUpdateLike() {
        let isFavorite = Database.shared.movieIsFavorite(movie)
        if isFavorite {
            Database.shared.removeMovieFromFavorites(movie) { (success, error) in
                if let error = error {
                    print("Failed to remove from favorites", error)
                    return
                }
                if success {
                    self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "favorite")
                }
            }
        } else {
            Database.shared.addMovieToFavorites(movie) { (success, error) in
                if let error = error {
                    print("Failed to add to favorites", error)
                    return
                }
                if success {
                    self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "favorite_filled")
                }
            }
        }
    }
    
    //MARK:- Collection View
    
    fileprivate func setupCollectionView() {
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .black
        collectionView.register(MovieHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        collectionView.register(OverviewCell.self, forCellWithReuseIdentifier: overviewCellId)
        collectionView.register(TrailerCell.self, forCellWithReuseIdentifier: trailerCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId, for: indexPath) as! MovieHeader
        header.movie = movie
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trailerCellId, for: indexPath) as! TrailerCell
            cell.videoId = movie.videos![0].key
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: overviewCellId, for: indexPath) as! OverviewCell
            cell.movie = movie
            return cell
        }
       
    }
        
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.videos != nil ? 2 : 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- UICollectionViewDelegateFlowLayout

extension MovieDetailController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = view.frame.width - 28
        var height: CGFloat = 0
        
        switch indexPath.row {
        case 1:
            height = width * 0.56
        default:
            height = movie.overview.height(withConstrainedWidth: width-2*14, font: .boldSystemFont(ofSize: 16)) + 54
        }
        
        
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        let height = 3*width/2
        return .init(width: width, height: height)
    }
    
}
