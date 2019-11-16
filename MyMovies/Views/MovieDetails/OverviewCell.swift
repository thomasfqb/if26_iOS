//
//  OverviewCell.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 10/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import UIKit

class OverviewCell: UICollectionViewCell {
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            overviewLabel.text = movie.overview
            dateLabel.text = movie.releaseDate
            rateLabel.text = "⭐️ \(movie.voteAverage)"
        }
    }

    lazy var dateLabel = createLabel(text: "")
    lazy var rateLabel = createLabel(text: "")
    
    let overviewLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        overviewLabel.textColor = .gray
        overviewLabel.textAlignment = .justified
        
        let topStackView = UIStackView(arrangedSubviews: [
            dateLabel,
            rateLabel
        ])
        topStackView.constrainHeight(constant: 20)
        topStackView.spacing = 12
        topStackView.distribution = .equalSpacing
        topStackView.alignment = .center
        
        let mainStackView = VerticalStackView(arrangedSubviews: [
            topStackView,
            overviewLabel
        ], spacing: 12)
        
        addSubview(mainStackView)
        mainStackView.fillSuperview(padding: .init(top: 8, left: 14, bottom: 14, right: 14))
    }
    
    
    fileprivate func createLabel(text: String) -> UILabel {
        let label = UILabel(text: text, font: .boldSystemFont(ofSize: 16), numberOfLines: 1)
        label.textColor = .white
        return label
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
