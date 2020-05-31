//
//  UINavigationController+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import UIKit

// MARK:- Instance Methods
public extension UINavigationController {
    
    func popBack(count: Int) {
        guard count > 0 else { return }
        let index = viewControllers.count - count - 1
        guard index >= 0 else { return }
        popToViewController(viewControllers[index], animated: true)
    }
}
