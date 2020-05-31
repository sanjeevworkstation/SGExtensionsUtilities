//
//  URLQueryItem+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import Foundation

// MARK:- Variables
public extension URLQueryItem {
    
    var dictionaryRepresentation: [String: String]? {
        if let value = value { return [name: value] }
        return nil
    }
}
