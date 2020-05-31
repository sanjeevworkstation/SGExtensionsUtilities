//
//  Sequence+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import Foundation

// MARK:- Instance Methods
public extension Sequence {
    
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T?>) -> [Element] {
        return sorted { a, b in
            if let val1 = a[keyPath: keyPath], let val2 = b[keyPath: keyPath] {
                return val1 < val2
            }
            return false
        }
    }
    
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { a, b in
            return a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
}
