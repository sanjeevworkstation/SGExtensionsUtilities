//
//  CALayer+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

// MARK:- Instance Methods
public extension CALayer {
    
    func applyShadowView(color: UIColor = .black, alpha: Float = 0.1, x: CGFloat = 0, y: CGFloat = 5, blur: CGFloat = 10, spread: CGFloat = 0) {
        
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
