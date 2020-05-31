//
//  UICollectionViewLayout+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import UIKit

// MARK:- Static Methods
public extension UICollectionViewLayout {
    
    static func configureLayout(scrollDirection: UICollectionView.ScrollDirection, sectionInsets: UIEdgeInsets, minimumInteritemSpacing: CGFloat = 10, minimumLineSpacing: CGFloat = 10) -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        layout.sectionInset = sectionInsets
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = minimumLineSpacing
        return layout
    }
}
