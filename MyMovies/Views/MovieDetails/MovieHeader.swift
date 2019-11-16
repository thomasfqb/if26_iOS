//
//  MovieHeader.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 10/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import UIKit

class MovieHeader: UICollectionReusableView {

    let posterImageView = UIImageView(image: #imageLiteral(resourceName: "poster"))
    let titleLabel = UILabel(text: "My movie title is large", font: .systemFont(ofSize: 48, weight: .heavy), numberOfLines: 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        posterImageView.contentMode = .scaleAspectFill
        addSubview(posterImageView)
        posterImageView.fillSuperview()
        
        setupGradientLayer()
        
        titleLabel.textColor = .white
        addSubview(titleLabel)
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 14, bottom: 18, right: 14))
        
        
        
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.6).cgColor,
        ]
        gradientLayer.locations = [0, 1]
        
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
