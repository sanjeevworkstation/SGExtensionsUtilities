//
//  UICollectionView+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import UIKit

// MARK:- Register
public extension UICollectionView {
    
    func registerNib(cellIdentifier: String) {
        self.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func registerHeaderNib(headerIdentifier: String) {
        self.register(UINib(nibName: headerIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
    
    func registerFooterNib(footerIdentifier: String) {
        self.register(UINib(nibName: footerIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerIdentifier)
    }
    
    func registerReusableHeaderNibs(cellIdentifiers: [String]) {
        for identifier in cellIdentifiers {
            self.register(UINib(nibName: identifier,bundle:nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier)
        }
    }
    
    func registerReusableFooterNibs(cellIdentifiers: [String]) {
        for identifier in cellIdentifiers {
            self.register(UINib(nibName: identifier,bundle:nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier)
        }
    }
}

// MARK:- Instance Methods
public extension UICollectionView {
    
    func scrollToSupplementaryView(kind: String, indexPath: IndexPath, scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        
        self.layoutIfNeeded()
        if let layoutAttributes =  self.layoutAttributesForSupplementaryElement(ofKind: kind, at: indexPath) {
            let viewOrigin = CGPoint(x: layoutAttributes.frame.origin.x, y: layoutAttributes.frame.origin.y);
            var resultOffset : CGPoint = self.contentOffset;
            
            switch(scrollPosition) {
            case .top:
                resultOffset.y = viewOrigin.y - self.contentInset.top
                
            case .left:
                resultOffset.x = viewOrigin.x - self.contentInset.left
                
            case .right:
                resultOffset.x = (viewOrigin.x - self.contentInset.left) - (self.frame.size.width - layoutAttributes.frame.size.width)
                
            case .bottom:
                resultOffset.y = (viewOrigin.y - self.contentInset.top) - (self.frame.size.height - layoutAttributes.frame.size.height)
                
            case .centeredVertically:
                resultOffset.y = (viewOrigin.y - self.contentInset.top) - (self.frame.size.height / 2 - layoutAttributes.frame.size.height / 2)
                
            case .centeredHorizontally:
                resultOffset.x = (viewOrigin.x - self.contentInset.left) - (self.frame.size.width / 2 - layoutAttributes.frame.size.width / 2)
            default:
                break;
            }
            self.setContentOffset(resultOffset, animated: true)
        }
    }
}
