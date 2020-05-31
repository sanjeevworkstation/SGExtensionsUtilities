//
//  NSMutableAttributedString+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 29/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import Foundation
import UIKit

// MARK:- Instance Methods
public extension NSMutableAttributedString {
    
    func appendText(text:String, font: UIFont? = nil, foregroundColor : UIColor? = nil) -> NSMutableAttributedString {
        var regularFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key: Any]()
        if let f = font {
            regularFontAttribute[NSAttributedString.Key.font] = f
        }
        if let color = foregroundColor {
            regularFontAttribute[NSAttributedString.Key.foregroundColor] = color
        }
        let normal =  NSMutableAttributedString(string: text, attributes: regularFontAttribute)
        self.append(normal)
        return self
    }
    
    func underline(appendText: String, underlineColor: UIColor, font: UIFont, underlineStyle: Int = 1, foregroundColor: UIColor? = nil) -> NSMutableAttributedString {
        
        let colorText =  NSMutableAttributedString(string: appendText)
        colorText.setUnderlineAttributes(underlineColor: underlineColor, font: font, foregroundColor: foregroundColor, underlineStyle: underlineStyle, range: nil)
        self.append(colorText)
        return self
    }
    
    func setUnderlineAttributes(underlineColor: UIColor, font: UIFont? = nil, foregroundColor: UIColor? = nil, underlineStyle: Int = 1,  range: NSRange? = nil) {
        
        let attr :[NSAttributedString.Key: Any] = [NSAttributedString.Key.underlineStyle : underlineStyle, NSAttributedString.Key.underlineColor : underlineColor]
        
        var stringRange = NSRange(location: 0, length: self.length)
        if let value = range {
            stringRange = value
        }
        self.addAttributes(attr, range: stringRange)
        
        if let value = font {
            self.addAttribute(NSAttributedString.Key.font, value: value, range: stringRange)
        }
        if let value = foregroundColor {
            self.addAttribute(NSAttributedString.Key.foregroundColor, value: value, range: stringRange)
        }
    }
    
    func setParagraphStyle(spacing: CGFloat, alignment: NSTextAlignment = .left) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = alignment
        self.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, self.length))
    }
}
