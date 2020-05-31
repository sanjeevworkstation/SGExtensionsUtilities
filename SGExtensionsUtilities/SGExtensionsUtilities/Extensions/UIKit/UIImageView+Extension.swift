//
//  UIImageView+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import UIKit

// MARK:-
extension UIImageView {
    
    func tintImageColor(color: UIColor) {
        if let image = self.image?.withRenderingMode(.alwaysTemplate) {
            self.image = image
        }
        self.tintColor = color
    }
}
