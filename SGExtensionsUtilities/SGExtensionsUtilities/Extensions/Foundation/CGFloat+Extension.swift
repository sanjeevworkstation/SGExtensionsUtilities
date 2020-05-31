//
//  CGFloat+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import Foundation
import UIKit

// MARK:- Variables
public extension CGFloat {
    
    var string: String {
        return String(format: "%.0f", self)
    }
}
