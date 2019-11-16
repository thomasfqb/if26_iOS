//
//  MovieHeader.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 10/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import UIKit
import SDWebImage

class MovieHeader: UICollectionReusableView {
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            titleLabel.text = movie.originalTitle
            let url = URL(string: "\(Service.imageBaseUrl)\(movie.posterPath ?? "")")
            posterImageView.sd_setImage(with: url)
        }
    }

    let posterImageView = UIImageView(image: #imageLiteral(resourceName: "poster"))
    let titleLabel = UILabel(text: "", font: .systemFont(ofSize: 44, weight: .heavy), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        posterImageView.contentMode = .scaleAspectFill
        addSubview(posterImageView)
        posterImageView.fillSuperview()
        
        
        setupGradientLayer()
        
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
        addSubview(titleLabel)
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 14, bottom: 14, right: 14))
        
        
        
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()

        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0, 0.9, 1]
        
        let gradientContainerView = UIView()
        addSubview(gradientContainerView)
        gradientContainerView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        gradientContainerView.layer.addSublayer(gradientLayer)
        gradientLayer.frame = bounds
        gradientLayer.frame.origin.y -= bounds.height
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
