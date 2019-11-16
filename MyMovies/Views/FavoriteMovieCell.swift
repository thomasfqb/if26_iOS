//
//  FavoriteMovieCell.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 10/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteMovieCell: BaseCell {

    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            let url = URL(string: "\(Service.imageBaseUrl)\(movie.posterPath ?? "")")
            posterImageView.sd_setImage(with: url)
        }
    }
    
    let posterImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(posterImageView)
        posterImageView.fillSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.roundCorners(corners: .allCorners, radius: cornerRadius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
