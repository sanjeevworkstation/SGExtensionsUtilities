//
//  UIApplication+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import UIKit

// MARK:- Class Methods
extension UIApplication {
    
    // MARK: Current
    class func currentAppVersion(bundle: Bundle = Bundle.main) -> String? {
        return bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    class func currentAppBuild(bundle: Bundle = Bundle.main) -> String? {
        return bundle.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    class func currentOsVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    // MARK: Class Methods
    class func isLowerAppVersion(appVersion: String) -> Bool? {
        if let appVersion = UIApplication.currentAppVersion() {
            let versionCompare = appVersion.compare(appVersion, options: .numeric)
            if versionCompare == .orderedSame {
                return false
            } else if versionCompare == .orderedAscending {
                return false
            } else if versionCompare == .orderedDescending {
                return true
            }
        }
        return nil
    }
    
    class func isHigherAppVersion(appVersion: String) -> Bool? {
        if let appVersion = UIApplication.currentAppVersion() {
            let versionCompare = appVersion.compare(appVersion, options: .numeric)
            if versionCompare == .orderedSame {
                return false
            } else if versionCompare == .orderedAscending {
                return true
            } else if versionCompare == .orderedDescending {
                return false
            }
        }
        return nil
    }
}
