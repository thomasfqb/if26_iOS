//
//  MovieCell.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 10/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: BaseCell {
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            titleLabel.text = movie.originalTitle
            let url = URL(string: "\(Service.imageBaseUrl)\(movie.posterPath ?? "")")
            moviePosterImageView.sd_setImage(with: url)
            dateLabel.text = movie.releaseDate
            rateLabel.text = "⭐️ \(movie.voteAverage)"
        }
    }
    
    let moviePosterImageView = UIImageView()
    let titleLabel = UILabel(text: "My movie Title", font: .systemFont(ofSize: 24, weight: .heavy), numberOfLines: 2)
    let dateLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 16), numberOfLines: 1)
    let rateLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 16), numberOfLines: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        dateLabel.textColor = .gray
        rateLabel.textColor = .gray
        
        let paddingView = UIView()
        paddingView.constrainHeight(constant: 2)
        
        let infoStackView = VerticalStackView(arrangedSubviews: [
            paddingView,
            titleLabel,
            dateLabel,
            rateLabel,
            UIView()
        ], spacing: 8)
        
        let height = frame.height
        let width = 2*height/3
        
        moviePosterImageView.constrainWidth(constant: width)
        let mainStackView = UIStackView(arrangedSubviews: [
            moviePosterImageView,
            infoStackView
        ])
        mainStackView.spacing = 8
        
        addSubview(mainStackView)
        mainStackView.fillSuperview(padding: .init(top: 0, left: 0, bottom: 0, right: 8))
        
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        moviePosterImageView.roundCorners(corners: [.bottomLeft, .topLeft], radius: cornerRadius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
