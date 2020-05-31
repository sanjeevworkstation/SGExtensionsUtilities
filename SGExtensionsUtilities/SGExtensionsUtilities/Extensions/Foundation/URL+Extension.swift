//
//  URL+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import Foundation

// MARK:- Variables
public extension URL {
    
    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
            return nil
        }
        
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        return parameters
    }
}

// MARK:- Instance Methods
public extension URL {
    
    func queryDictionary() -> [String:AnyObject] {
        let components = self.query?.components(separatedBy: "&")
        var dictionary = [String:AnyObject]()
        
        for pairs in components ?? [] {
            let pair = pairs.components(separatedBy: "=")
            if pair.count == 2 {
                dictionary[pair[0]] = pair[1] as AnyObject
            }
        }
        return dictionary
    }
}
