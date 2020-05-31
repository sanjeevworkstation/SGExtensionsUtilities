//
//  UIViewController+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import UIKit

// MARK:- Instance Methods
public extension UIViewController {
    
    func setupViewToSuperview(view: UIView) {
        setUpViewInViewController(containerView: view, constraintsToSuperView: true)
    }
    
    func setupViewToSafeArea(view: UIView) {
        setUpViewInViewController(containerView: view, constraintsToSuperView: false)
    }
    
    private func setUpViewInViewController(containerView: UIView, constraintsToSuperView: Bool = false) {
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        
        if constraintsToSuperView {
            containerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0).isActive = true
            containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
        }
        else {
            containerView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
            containerView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor, constant: 0.0).isActive = true
        }
    }
    
    func getBottomPadding() -> CGFloat {
        if #available(iOS 11.0, *) {
            let bottomPadding = UIApplication.shared.keyWindow?.safeAreaInsets.bottom
            return bottomPadding!
        } else {
            // Fallback on earlier versions
        }
        return 0
    }
    
    func getStatusBarHeight() -> CGFloat {
        let height = UIApplication.shared.statusBarFrame.height
        return height
    }
    
    func isModallyPresented() -> Bool {
        if (self.presentingViewController != nil) {
            return true
        }
        
        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController {
            return true
        }
        return false
    }
    
    func addChildViewController(childViewController: UIViewController, parentView: UIView) {
        addChild(childViewController)
        parentView.addSubview(childViewController.view)
        childViewController.view.frame = parentView.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParent: self)
    }
    
    func removeFromParentViewController() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
