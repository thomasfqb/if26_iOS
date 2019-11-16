//
//  StretchyHeaderLayout.swift
//  FoodSaver
//
//  Created by Thomas Fauquemberg on 18/06/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import UIKit

// Ref: https://www.youtube.com/watch?v=uvTLGIJaRGk

class StretchyHeaderLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach({ (attribute) in
            if attribute.representedElementKind == UICollectionView.elementKindSectionHeader && attribute.indexPath.section == 0 {
                
                guard let collectionView = collectionView else { return }
                let width = collectionView.frame.width
                
                let contentOffsetY = collectionView.contentOffset.y
                
                if contentOffsetY > 0 {
                    return
                }

                let height = attribute.frame.height - contentOffsetY
                
                attribute.frame = .init(x: 0, y: contentOffsetY, width: width, height: height)
            }
        })
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
