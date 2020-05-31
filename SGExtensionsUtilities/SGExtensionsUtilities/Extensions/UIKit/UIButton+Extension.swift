//
//  UIButton+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import UIKit

// MARK:- Instance Methods
public extension UIButton {
    
    func inverseButtonImageWithPadding(shouldInverse: Bool = false, inBetweenPadding: CGFloat = 10.0) {
        guard let value = self.title(for: .normal) else { return }
        
        guard shouldInverse else {
            self.imageEdgeInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: inBetweenPadding)
            return
        }
        
        let stringWidth = value.width(withConstraintedHeight: self.frame.size.height, font: self.titleLabel!.font)
        
        var buttonImageWidth:CGFloat = 0.0
        if let buttonImage = self.currentImage {
            buttonImageWidth = buttonImage.size.width
        }
        
        self.contentHorizontalAlignment = .center
        let imageHorizontalInset:CGFloat =  (stringWidth * 2) - (buttonImageWidth / 2)
        self.imageEdgeInsets = UIEdgeInsets.init(top: 0.0, left: imageHorizontalInset, bottom: 0.0, right: 0.0)
        
        let titleHorizontalInset:CGFloat = (buttonImageWidth * 2) + (inBetweenPadding * 2)
        self.titleEdgeInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: titleHorizontalInset)
    }
    
    func setButtonImageFromLeftWithPadding(leftPadding: CGFloat = 0.0, titleRightPadding: CGFloat = 0.0, isTitleCentered: Bool = true, adjustTitleForImagePadding: Bool = false) {
        
        guard let value = self.title(for: .normal) else { return }
        
        let stringWidth = value.width(withConstraintedHeight: self.frame.size.height, font: self.titleLabel!.font)
        let buttonWidth = self.frame.size.width
        
        var buttonImageWidth:CGFloat = 0.0
        if let buttonImage = self.currentImage {
            buttonImageWidth = buttonImage.size.width
        }
        
        self.contentHorizontalAlignment = .left
        let imageHorizontalInset:CGFloat = leftPadding
        self.imageEdgeInsets = UIEdgeInsets.init(top: 0.0, left: imageHorizontalInset, bottom: 0.0, right: 0.0)
        
        if !isTitleCentered {
            let titleHorizontalInset:CGFloat = buttonWidth - (stringWidth + buttonImageWidth + titleRightPadding)
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0.0, left: titleHorizontalInset, bottom: 0.0, right: 0.0)
        }
            
        else if adjustTitleForImagePadding {
            //Sets title in the center accounting for the image on the Left
            let titleHorizontalInset = (buttonWidth - (leftPadding + stringWidth)) / 2
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0.0, left: titleHorizontalInset, bottom: 0.0, right: 0.0)
        }
            
        else {
            //Sets title in the center WITHOUT accounting for the image on the Left
            let titleHorizontalInset = ((buttonWidth - stringWidth) / 2) - buttonImageWidth
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0.0, left: titleHorizontalInset, bottom: 0.0, right: 0.0)
        }
        
    }
    
    func setButtonImageFromRightWithPadding(rightPadding: CGFloat = 0.0, titleLeftPadding: CGFloat = 0.0, isTitleCentered: Bool = true, adjustTitleForImagePadding: Bool = false) {
        
        guard let value = self.title(for: .normal) else { return }
        
        let stringWidth = value.width(withConstraintedHeight: self.frame.size.height, font: self.titleLabel!.font)
        let buttonWidth = self.frame.size.width
        
        var buttonImageWidth:CGFloat = 0.0
        if let buttonImage = self.currentImage {
            buttonImageWidth = buttonImage.size.width
        }
        
        self.contentHorizontalAlignment = .left
        let imageHorizontalInset = buttonWidth - (buttonImageWidth) - rightPadding
        self.imageEdgeInsets = UIEdgeInsets.init(top: 0.0, left: imageHorizontalInset, bottom: 0.0, right: 0.0)
        
        if !isTitleCentered {
            //Sets title all the way to the left minus the padding you want
            let titleInsetLeft = titleLeftPadding - buttonImageWidth
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0.0, left: titleInsetLeft, bottom: 0.0, right: 0.0)
        }
            
        else if adjustTitleForImagePadding {
            //Sets title in the center accounting for the image on the right
            let titleHorizontalInset = (((buttonWidth - buttonImageWidth - rightPadding) - stringWidth) / 2) - buttonImageWidth
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0.0, left: titleHorizontalInset, bottom: 0.0, right: 0.0)
        }
            
        else {
            //Sets title in the center WITHOUT accounting for the image on the right
            let titleHorizontalInset = ((buttonWidth - stringWidth) / 2) - buttonImageWidth
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0.0, left: titleHorizontalInset, bottom: 0.0, right: 0.0)
        }
    }
}
