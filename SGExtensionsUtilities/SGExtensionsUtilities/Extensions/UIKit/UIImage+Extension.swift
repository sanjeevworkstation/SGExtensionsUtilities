//
//  UIImage+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import UIKit

// MARK:- Class Methods
public extension UIImage {
    
    class func imageWithColor(color: UIColor, width: CGFloat = 1.0, height: CGFloat = 1.0) -> UIImage {
        var rect: CGRect = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        
        if width == 0 {
            rect.size.width = 1.0
        }
        
        if height == 0 {
            rect.size.height = 1.0
        }
        
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    static func build(assetNamed: String, renderingMode: UIImage.RenderingMode? = nil) -> UIImage? {
        if let renderingMode = renderingMode {
            return UIImage(named: assetNamed)?.withRenderingMode(renderingMode)
        } else {
            return UIImage(named: assetNamed)
        }
    }
    
    class func outlinedEllipse(size: CGSize, color: UIColor, lineWidth: CGFloat = 1.0) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(lineWidth)
        // Inset the rect to account for the fact that strokes are
        // centred on the bounds of the shape.
        let rect = CGRect(origin: .zero, size: size).insetBy(dx: lineWidth * 0.5, dy: lineWidth * 0.5)
        context.addEllipse(in: rect)
        context.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

// MARK:- Variables
public extension UIImage {
    var data: Data? {
        return self.jpegData(compressionQuality: 1)
    }
}


// MARK:- Instance Methods
public extension UIImage {
    
    func convertToBase64String(compression: CGFloat = 1.0) -> String? {
        let imageData = self.jpegData(compressionQuality: compression)
        if let base64String = imageData?.base64EncodedString(options: .lineLength64Characters) {
            return "data:image/jpeg;base64,\(base64String)"
        }
        return nil
    }
}
