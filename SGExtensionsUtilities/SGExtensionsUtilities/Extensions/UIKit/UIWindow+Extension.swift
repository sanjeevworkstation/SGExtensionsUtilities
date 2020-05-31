//
//  UIWindow+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import UIKit

// MARK:- Instance Methods
public extension UIWindow {
    
    func topMostWindowController()-> UIViewController? {
        var topController = rootViewController
        
        while let presentedController = topController?.presentedViewController {
            topController = presentedController
        }
        return topController
    }
    
    func currentViewController() -> UIViewController? {
        var currentViewController = topMostWindowController()
        while currentViewController is UINavigationController && (currentViewController as? UINavigationController)?.topViewController != nil {
            currentViewController = (currentViewController as? UINavigationController)?.topViewController
        }
        return nil
    }
}
