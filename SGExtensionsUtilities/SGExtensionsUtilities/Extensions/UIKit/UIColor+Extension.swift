//
//  UIColor+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import UIKit

// MARK:- Class Methods
public extension UIColor {
    class func color(HEXValue: String, alpha: CGFloat = 1.0) -> UIColor {
        var newHEXValue:String = HEXValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (newHEXValue.hasPrefix("#")) {
            newHEXValue.remove(at: newHEXValue.startIndex)
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: newHEXValue).scanHexInt32(&rgbValue)
        
        if ((newHEXValue.count) == 6) {
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: alpha
            )
        } else if ((newHEXValue.count) == 8) {
            return UIColor(
                red: CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x000000FF) / 255.0,
                alpha: CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
            )
        } else {
            return UIColor.gray
        }
    }
}

// MARK:- Variables
public extension UIColor {
    
    var hexValue: String? {
        if let colorComponents = self.cgColor.components {
            let r = colorComponents[0]
            let g = colorComponents[1]
            let b = colorComponents[2]
            return  String(format: "%02X%02X%02X", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
        }
        return nil
    }
}

// MARK:- Instance Methods
public extension UIColor {
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgba:Int = (Int)(r*255)<<24 | (Int)(g*255)<<16 | (Int)(b*255)<<8 | (Int)(a*255)<<0
        return String(format:"#%08X", rgba)
    }
    
    func getColorWithTranslucency(isTranslucent: Bool = true) -> UIColor {
        let colorComponents =  self.getRGBAComponents()
        if !isTranslucent || colorComponents == nil {
            return self
        } else {
            let red = colorComponents!.red
            let green = colorComponents!.green
            let blue = colorComponents!.blue
            let alpha = colorComponents!.alpha
            
            let minimumColorValue:CGFloat = 40
            let maximumColorValue:CGFloat = 255.0
            let newRed = red >= minimumColorValue ? getNewValueForColor(color: red) : red
            let newGreen = green >= minimumColorValue ? getNewValueForColor(color: green) : green
            let newBlue = blue >= minimumColorValue ? getNewValueForColor(color: blue) : blue
            
            return UIColor(red: newRed/maximumColorValue, green: newGreen/maximumColorValue, blue: newBlue/maximumColorValue, alpha: alpha)
        }
    }
    
    func getRGBAComponents() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        let maximumColorValue:CGFloat = 255.0
        var (red, green, blue, alpha) = (CGFloat(0.0), CGFloat(0.0), CGFloat(0.0), CGFloat(0.0))
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return (red * maximumColorValue, green * maximumColorValue, blue * maximumColorValue, alpha)
        } else {
            return nil
        }
    }
    
    private func getNewValueForColor(color: CGFloat) -> CGFloat {
        let minimumColorValue:CGFloat = 40.0
        let maximumColorValue:CGFloat = 255.0
        let baseColorValue:CGFloat = 1.0
        return (color - minimumColorValue) / (baseColorValue - (minimumColorValue / maximumColorValue))
    }
}
