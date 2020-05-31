//
//  UITableView+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import UIKit

// MARK:-
public extension UITableView {
    
    var isTableHeaderViewVisible: Bool {
        guard let tableHeaderView = tableHeaderView else {
            return false
        }
        let currentYOffset = self.contentOffset.y
        let headerHeight = tableHeaderView.frame.size.height
        return currentYOffset < headerHeight
    }
}

// MARK:-
public extension UITableView {
    class func addFooterViewForListings(height: CGFloat = 10.0, width: CGFloat = SGUtilities.Device.ScreenSize.width) -> UIView {
        return UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
    }
}

// MARK:-
public extension UITableView {
    
    // MARK: Header Layouting
    func sizeHeaderToFit() {
        if let headerView = self.tableHeaderView {
            
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
            
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var frame = headerView.frame
            frame.size.height = height
            headerView.frame = frame
            self.tableHeaderView = headerView
        }
    }
    
    func sizeFooterToFit() {
        if let footerView = tableFooterView {
            footerView.setNeedsLayout()
            footerView.layoutIfNeeded()
            let height = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var frame = footerView.frame
            frame.size.height = height
            footerView.frame = frame
            tableFooterView = footerView
        }
    }
    
    func prepareForTableHeader(width: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let widthConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        
        self.addConstraint(widthConstraint)
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        let height = self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        self.removeConstraint(widthConstraint)
        
        self.frame.size.height = height
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    
    // MARK: Refresh control
    func addRefreshControl() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        if #available(iOS 10.0, *) {
            self.refreshControl = refreshControl
        } else {
            self.addSubview(refreshControl)
        }
        return refreshControl
    }
}

// MARK:- Register
public extension UITableView {
    
    func registerNibs(cellIdentifiers: [String]) {
        for identifier in cellIdentifiers {
            self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
    
    func registerNib(cellIdentifier: String) {
        self.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func registerHeaderNibs(cellIdentifiers: [String]) {
        for identifier in cellIdentifiers {
            self.register(UINib(nibName: identifier,bundle:nil), forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
}
