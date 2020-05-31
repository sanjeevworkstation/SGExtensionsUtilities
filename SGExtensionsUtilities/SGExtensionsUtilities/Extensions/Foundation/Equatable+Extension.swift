//
//  Equatable+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import Foundation

// MARK:- Instance Methods
public extension Equatable {
    
    func oneOf(other: Self...) -> Bool {
        return other.contains(self)
    }
}
