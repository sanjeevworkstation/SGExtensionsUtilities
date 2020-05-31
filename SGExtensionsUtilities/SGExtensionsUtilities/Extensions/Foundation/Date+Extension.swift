//
//  Date+Extension.swift
//  SGSwiftExtensionsWithUtilities
//
//  Created by Sanjeev Gautam on 28/05/20.
//  Copyright © 2020 SG. All rights reserved.
//

import Foundation

// MARK:- Instance Methods
public extension Date {
    
    func toStringWithTimeZone(format:String = "EEE, dd-MMM-yy 'at' hh:mm aa", timezone:TimeZone = TimeZone.current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timezone
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
    
    func newDate(hours: Int) -> Date? {
        return newDate(hour: hours)
    }
    
    func newDate(minutes: Int) -> Date? {
        return newDate(minute: minutes)
    }
    
    func newDate(seconds: Int) -> Date? {
        return newDate(second: seconds)
    }
    
    func newDate(days: Int) -> Date? {
        return newDate(day: days)
    }
    
    func newDate(months: Int) -> Date? {
        return newDate(month: months)
    }
    
    func newDate(years: Int) -> Date? {
        return newDate(year: years)
    }
    
    func newDate(hour:Int? = nil, minute:Int? = nil, second:Int? = nil, day:Int? = nil, month:Int? = nil, year:Int? = nil) -> Date? {
        
        var components: DateComponents = DateComponents()
        components.hour = hour
        components.minute = minute
        components.second = second
        components.day = day
        components.month = month
        components.year = year
        return Calendar.current.date(byAdding: components, to: self)
        
    }
    
    func years(fromDate: Date) -> Int? {
        return Calendar.current.dateComponents([.year], from: fromDate, to: self).year
    }
    
    func months(fromDate: Date) -> Int? {
        return Calendar.current.dateComponents([.month], from: fromDate, to: self).month
    }
    
    func weeks(fromDate: Date) -> Int? {
        return Calendar.current.dateComponents([.weekOfMonth], from: fromDate, to: self).weekOfMonth
    }
    
    func days(fromDate: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: fromDate, to: self).day
    }
    
    func hours(fromDate: Date) -> Int? {
        return Calendar.current.dateComponents([.hour], from: fromDate, to: self).hour
    }
    
    func minutes(fromDate: Date) -> Int? {
        return Calendar.current.dateComponents([.minute], from: fromDate, to: self).minute
    }
    
    func seconds(fromDate: Date) -> Int? {
        return Calendar.current.dateComponents([.second], from: fromDate, to: self).second
    }
}

// MARK:- Static Methods
public extension Date {
    
    static func difference(startDate: Date, endDate: Date, differenceBy: Calendar.Component) -> DateComponents? {
        let calendar = NSCalendar.current
        let date1 = calendar.startOfDay(for: startDate)
        let date2 = calendar.startOfDay(for: endDate)
        let components = calendar.dateComponents([differenceBy], from: date1, to: date2)
        return components
    }
    
    static func eraDifference(startDate: Date, endDate: Date) -> Int? {
        return self.difference(startDate: startDate, endDate: endDate, differenceBy: .era)?.era
    }
    
    static func yearsDifference(startDate: Date, endDate: Date) -> Int? {
        return self.difference(startDate: startDate, endDate: endDate, differenceBy: .year)?.year
    }
    
    static func monthsDifference(startDate: Date, endDate: Date) -> Int? {
        return self.difference(startDate: startDate, endDate: endDate, differenceBy: .month)?.month
    }
    
    static func daysDifference(startDate: Date, endDate: Date) -> Int? {
        return self.difference(startDate: startDate, endDate: endDate, differenceBy: .day)?.day
    }
    
    static func hoursDifference(startDate: Date, endDate: Date) -> Int? {
        return self.difference(startDate: startDate, endDate: endDate, differenceBy: .hour)?.hour
    }
    
    static func minutesDifference(startDate: Date, endDate: Date) -> Int? {
        return self.difference(startDate: startDate, endDate: endDate, differenceBy: .minute)?.minute
    }
    
    static func secondsDifference(startDate: Date, endDate: Date) -> Int? {
        return self.difference(startDate: startDate, endDate: endDate, differenceBy: .second)?.second
    }
    
    static func weekdaysDifference(startDate: Date, endDate: Date) -> Int? {
        return self.difference(startDate: startDate, endDate: endDate, differenceBy: .weekday)?.weekday
    }
    
    static func weekdayOrdinalDifference(startDate: Date, endDate: Date) -> Int? {
        return self.difference(startDate: startDate, endDate: endDate, differenceBy: .weekdayOrdinal)?.weekdayOrdinal
    }
    
    static func quarterDifference(startDate: Date, endDate: Date) -> Int? {
        return self.difference(startDate: startDate, endDate: endDate, differenceBy: .quarter)?.quarter
    }
    
    static func weekOfMonthDifference(startDate: Date, endDate: Date) -> Int? {
        return self.difference(startDate: startDate, endDate: endDate, differenceBy: .weekOfMonth)?.weekOfMonth
    }
    
    static func weekOfYearDifference(startDate: Date, endDate: Date) -> Int? {
        return self.difference(startDate: startDate, endDate: endDate, differenceBy: .weekOfYear)?.weekOfYear
    }
    
    static func yearForWeekOfYearDifference(startDate: Date, endDate: Date) -> Int? {
        return self.difference(startDate: startDate, endDate: endDate, differenceBy: .yearForWeekOfYear)?.yearForWeekOfYear
    }
    
    static func nanosecondsDifference(startDate: Date, endDate: Date) -> Int? {
        return self.difference(startDate: startDate, endDate: endDate, differenceBy: .nanosecond)?.nanosecond
    }
}

// MARK:- Variables
public extension Date {
    var yearsFromNow: Int? { return Calendar.current.dateComponents([.year], from: self, to: Date()).year }
    var monthsFromNow: Int? { return Calendar.current.dateComponents([.month], from: self, to: Date()).month }
    var weeksFromNow: Int? { return Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear }
    var daysFromNow: Int? { return Calendar.current.dateComponents([.day], from: self, to: Date()).day }
    var hoursFromNow: Int? { return Calendar.current.dateComponents([.hour], from: self, to: Date()).hour }
    var minutesFromNow: Int? { return Calendar.current.dateComponents([.minute], from: self, to: Date()).minute }
    var secondsFromNow: Int? { return Calendar.current.dateComponents([.second], from: self, to: Date()).second }
}
