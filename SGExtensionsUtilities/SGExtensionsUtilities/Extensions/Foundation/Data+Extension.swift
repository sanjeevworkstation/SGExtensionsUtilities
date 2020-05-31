//
//  Data+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import Foundation

// MARK:- Variables
public extension Data {
    
    var sizeInBytes: Int {
        return self.count
    }
    
    var sizeInKB: Double {
        return Double(sizeInBytes) / 1024
    }
    
    var sizeInMB: Double {
        return Double(sizeInBytes) / (1024 * 1024)
    }
    
    var toJsonStringPrettyPrinted: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString
    }
}
