//
//  String+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import Foundation
import UIKit

// MARK:- Mutating Methods
public extension String {
    
    mutating func insert(string:String, index:Int) {
        self.insert(contentsOf: string, at:self.index(self.startIndex, offsetBy: index) )
    }
}

// MARK:- Instance Methods
public extension String {
    
    func contains(find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    func containsEmoji() -> Bool {
        for scalar in unicodeScalars {
            if #available(iOS 10.2, *) {
                return scalar.properties.isEmoji
            } else {
                // Fallback on earlier versions
                switch scalar.value {
                case 0x1F600...0x1F64F, // Emoticons
                0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                0x1F680...0x1F6FF, // Transport and Map
                0x2600...0x26FF,   // Misc symbols
                0x2700...0x27BF,   // Dingbats
                0xFE00...0xFE0F,   // Variation Selectors
                0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                0x1F1E6...0x1F1FF: // Flags
                    return true
                default:
                    continue
                }
            }
        }
        return false
    }
    
    func underlined(textColor: UIColor, font: UIFont) -> NSMutableAttributedString {
        
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.setUnderlineAttributes(underlineColor: textColor, font: font, foregroundColor: textColor, underlineStyle: NSUnderlineStyle.single.rawValue)
        return attributedString
    }
    
    func lineSpacing(lineSpacing: CGFloat) -> NSMutableAttributedString {
        let attr = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attr.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attr.length))
        return attr
    }
    
    func trimDuplicateValues() -> String {
        let splitName = self.split(separator: " ")
        if (splitName.count) > 1 {
            if splitName[0].caseInsensitiveCompare(splitName[1]) == .orderedSame {
                return String(splitName[0])
            } else {
                return self
            }
        }
        return self
    }
    
    func normaliseText() -> String {
        return self.folding(options: [.caseInsensitive, .diacriticInsensitive], locale: .current)
    }
    
    func formatDateString() -> String {
        if let myInteger = Int(self) {
            let myNumber = NSNumber(value:myInteger)
            let formatter = NumberFormatter()
            formatter.numberStyle = .ordinal
            return formatter.string(from: myNumber)!
        }
        return ""
    }
    
    func toDate(_ format : String = "EEE, dd-MMM-yy 'at' hh:mm aa") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date!
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func getHeightInLabel(font:UIFont, width:CGFloat, numberOfLines:Int = 0) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x:0, y:0, width:width, height:CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = numberOfLines
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = self
        label.sizeToFit()
        return label.frame.height
    }
    
    func evaluateStringWidth(lblFont:UIFont, leftPadding: CGFloat = 10, rightPadding: CGFloat = 10) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: lblFont]
        let attrString = NSAttributedString(string: self, attributes: attributes)
        return attrString.size().width + leftPadding + rightPadding
    }
    
    func height(withWidth width: CGFloat, font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [.font : font], context: nil)
        return actualSize.height
    }
    
    func pluralizeForInt(value: Int) -> String {
        let stringValue = self
        if value == 1 {
            return stringValue
        } else {
            return stringValue + "s"
        }
    }
    
    func encodeUrl() -> String? {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    
    func decodeUrl() -> String? {
        return self.removingPercentEncoding
    }
    
    func parseURL() -> Dictionary<String, String> {
        var paramDictionary = Dictionary<String, String>()
        let tokens = self.components(separatedBy: "&")
        for keyValuePair in tokens {
            let pairComponents = keyValuePair.components(separatedBy: "=")
            if let key = pairComponents.first?.removingPercentEncoding, let value = pairComponents.last?.removingPercentEncoding {
                paramDictionary[key] = value
            }
        }
        return paramDictionary
    }
    
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func matchesRegex(regex: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let nsString = self as NSString
            let match = regex.firstMatch(in: self, options: [], range: NSMakeRange(0, nsString.length))
            return (match != nil)
        } catch {
            return false
        }
    }
    
    func luhnCheck() -> Bool {
        var sum = 0
        let reversedCharacters = self.reversed().map { String($0) }
        for (idx, element) in reversedCharacters.enumerated() {
            guard let digit = Int(element) else { return false }
            switch ((idx % 2 == 1), digit) {
            case (true, 9): sum += 9
            case (true, 0...8): sum += (digit * 2) % 9
            default: sum += digit
            }
        }
        return sum % 10 == 0
    }
    
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return boundingBox.width
    }
    
    func width(constrainedHeight height: CGFloat, constrainedFont font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes:[NSAttributedString.Key.font: font],
                                            context: nil)
        return boundingBox.width
    }
    
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.height
    }
    
    func widthWithConstrainedHeight(height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
    
    var attributedStringFromHtml: NSAttributedString? {
        do {
            guard let data = self.data(using: String.Encoding.utf8) else { return nil }
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch _ {
            return nil
        }
    }
    
    func index(of string: String, from startPos: Index? = nil, options: CompareOptions = .literal) -> NSRange? {
        let startPos = startPos ?? startIndex
        let utf16view = self.utf16
        if let rangeOfString = range(of: string, options: options, range: startPos ..< endIndex) {
            if let lower16 = rangeOfString.lowerBound.samePosition(in: utf16view) {
                return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: lower16), string.count)
            }
        }
        return nil
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func nsRange(from range: Range<String.Index>) -> NSRange? {
        let utf16view = self.utf16
        if let from = range.lowerBound.samePosition(in: utf16view), let to = range.upperBound.samePosition(in: utf16view) {
            return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from), utf16view.distance(from: from, to: to))
        }
        return nil
    }
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        return label.frame.height
    }
    
    func getWidthAndHeight(width: CGFloat, font: UIFont) -> (width: CGFloat, height: CGFloat) {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        return (label.frame.width, label.frame.height)
    }
    
    func encodeStringForSpecialCharacters() -> String? {
        let customAllowedSet =  NSCharacterSet(charactersIn:"=+*$&\"#%/<>?@\\^`{|} ").inverted
        if let encodedAuthToken = self.addingPercentEncoding(withAllowedCharacters: customAllowedSet){
            return encodedAuthToken
        }
        return nil
    }
    
    func deletePrefix(prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func trimWithChar(char: String) -> String {
        var mutatingString = self
        
        while mutatingString.hasSuffix(char) {
            mutatingString = String(mutatingString.dropLast())
        }
        
        while mutatingString.hasPrefix(char) {
            mutatingString = String(mutatingString.dropFirst())
        }
        return mutatingString
    }
    
    func isGreaterThan(versionString: String) -> Bool {
        let versionCompare = self.compare(versionString, options: .numeric)
        return versionCompare == .orderedDescending
    }
    
    func isLessThanEqualTo(versionString: String) -> Bool {
        let versionCompare = self.compare(versionString, options: .numeric)
        return versionCompare == .orderedSame || versionCompare == .orderedAscending
    }
    
    func isEqualTo(versionString: String) -> Bool {
        let versionCompare = self.compare(versionString, options: .numeric)
        return versionCompare == .orderedSame
    }
}

// MARK:- Static Methods
public extension String {
    
    static func uniqueString() -> String {
        let uniqueString = ProcessInfo.processInfo.globallyUniqueString
        return uniqueString
    }
}

// MARK:- Variables
public extension String {
    
    var containsWhitespace: Bool {
        return (self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    
    var isBackspace: Bool? {
        if let char = self.cString(using: String.Encoding.utf8) {
            return strcmp(char, "\\b") == -92
        }
        return nil
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    
    var htmlToString: String? {
        return htmlToAttributedString?.string
    }
    
    var nsString: NSString {
        return self as NSString
    }
    
    var lastPathComponent: String {
        return nsString.lastPathComponent
    }
    
    var stringByDeletingPathExtension: String {
        return nsString.deletingPathExtension
    }
    
    var removingWhitespacesAndNewlines: String {
        return components(separatedBy: .whitespacesAndNewlines).joined(separator: " ")
    }
    
    var doubleValue: Double? {
        let tempValue = self.replacingOccurrences(of: ",", with: "")
        if let totalAmount = Double(tempValue) {
            return totalAmount
        }
        return nil
    }
}
