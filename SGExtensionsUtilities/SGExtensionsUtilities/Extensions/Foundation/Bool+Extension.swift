//
//  Bool+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import Foundation

// MARK:- Instance Methods
public extension Bool {
    
    func toInt() -> Int {
        if self {
            return 1
        } else {
            return 0
        }
    }
    
    func toString() -> String {
        if self {
            return "1"
        } else {
            return "0"
        }
    }
}
