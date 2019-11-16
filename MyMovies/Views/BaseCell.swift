//
//  BaseCell.swift
//  MyMovies
//
//  Created by Thomas Fauquemberg on 10/11/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            var transform: CGAffineTransform = .identity
            if isHighlighted {
                transform = .init(scaleX: 0.97, y: 0.97)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.transform = transform
                
            })
        }
    }
    
    let cornerRadius: CGFloat = 18
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = cornerRadius
        backgroundColor = .white
        setupShadow()
    }
    
    
    fileprivate func setupShadow() {
        // Using background view to keep content smooth when applying shouldRasterize = true
        self.backgroundView = UIView()
        addSubview(self.backgroundView!)
        self.backgroundView?.fillSuperview()
        self.backgroundView?.backgroundColor = .white
        self.backgroundView?.layer.cornerRadius = cornerRadius
        
        self.backgroundView?.layer.shadowOpacity = 0.1
        self.backgroundView?.layer.shadowRadius = 10
        self.backgroundView?.layer.shadowOffset = .init(width: 0, height: 8)
        self.backgroundView?.layer.shouldRasterize = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
