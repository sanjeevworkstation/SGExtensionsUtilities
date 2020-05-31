//
//  UILabel+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import UIKit

// MARK:- Instance Methods
public extension UILabel {
    
    func textHeight(width: CGFloat) -> CGFloat {
        guard let text = text else { return 0 }
        return text.height(withWidth: width, font: font)
    }
    
    func attributedTextHeight(width: CGFloat) -> CGFloat {
        guard let attributedText = attributedText else { return 0 }
        return attributedText.height(width: width)
    }
    
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}
