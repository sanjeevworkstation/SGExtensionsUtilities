//
//  Dictionary+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import Foundation

// MARK:- Instance Methods
public extension Dictionary {
    
    /// Merge and return a new dictionary
    func merge(with: Dictionary<Key,Value>) -> Dictionary<Key,Value> {
        var copy = self
        for (k, v) in with {
            // If a key is already present it will be overritten
            copy[k] = v
        }
        return copy
    }
}

// MARK:- Mutating Methods
public extension Dictionary {
    
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
    
    /// Merge in-place
    mutating func append(with: Dictionary<Key,Value>) {
        for (k, v) in with {
            // If a key is already present it will be overritten
            self[k] = v
        }
    }
}

// MARK:- Variables
public extension Dictionary {
    
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            if let keyString = String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let valueString = String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                let part = String(format: "%@=%@", keyString, valueString)
                parts.append(part as String)
            }
        }
        return parts.joined(separator: "&")
    }
    
    var jsonString: String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8)
        } catch {
            return nil
        }
    }
}
