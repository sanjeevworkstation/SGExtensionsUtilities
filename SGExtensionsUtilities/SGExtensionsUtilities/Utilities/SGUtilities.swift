//
//  SGUtilities.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

public struct SGUtilities {
    
    public struct OperatingSystem {
        public static var isHigherThaniOS10: Bool {
            if #available(iOS 10.0, *) {
                return true
            } else {
                return false
            }
        }
    }
}

// MARK:- Device
public extension SGUtilities {
    struct Device {
        
        public static func vibratePhone() {
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        
        public static func feedbackGenerateVibrate() {
            if #available(iOS 10.0, *) {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            } else {
                // Fallback on earlier versions
            }
        }
        
        public static var isSimulator: Bool {
            return TARGET_OS_SIMULATOR != 0
        }
        
        public struct Info {
            public static let osName:String = UIDevice.current.systemName // "iOS"
            public static let osVersion:String = UIDevice.current.systemVersion // "11.4"
            public static let name:String = UIDevice.current.name // "Sanjeev's iPhone"
            public static let uuid:String = UIDevice.current.identifierForVendor?.uuidString ?? ""
            public static let model:String = UIDevice.current.model // "iPhone"
            public static let deviceType:String? = UIDevice.deviceType() // "iPhone 7 Plus"
        }
        
        public struct ScreenSize {
            public static let width = UIScreen.main.bounds.size.width
            public static let height = UIScreen.main.bounds.size.height
            public static let maxLength = max(ScreenSize.width, ScreenSize.height)
            public static let minLength = min(ScreenSize.width, ScreenSize.height)
        }
        
        public struct Kind {
            public static let iPhone4OrLess = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength < 568.0
            public static let iPhone5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 568.0
            public static let iPhone6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 667.0
            public static let iPhone6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 736.0
            public static let iPhoneX = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.maxLength == 812.0
            public static let iPad = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.maxLength == 1024.0
        }
    }
}
