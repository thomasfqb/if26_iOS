//
//  UIView+CornerRadius.swift
//  FoodSaver
//
//  Created by Thomas Fauquemberg on 18/06/2019.
//  Copyright © 2019 Thomas Fauquemberg. All rights reserved.
//

import UIKit


// ⚠ do it in layoutSubviews
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
