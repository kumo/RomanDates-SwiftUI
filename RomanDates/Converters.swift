//
//  Converters.swift
//  RomanDates
//
//  Created by Robert Clarke on 08/05/2020.
//  Copyright © 2020 Robert Clarke. All rights reserved.
//

import Foundation

public enum RomanDateFormatter: Int {
    case dayMonthYear, monthDayYear, yearMonthDay
    case dayMonth, monthDay
    case dayMonthShortYear, monthDayShortYear, shortYearMonthDay

    mutating func removeYear() {
        switch self {
        case .dayMonthYear, .dayMonthShortYear:
            self = .dayMonth
        case .monthDayYear, .monthDayShortYear, .yearMonthDay, .shortYearMonthDay:
            self = .monthDay
        default:
            break
        }
    }

    mutating func useShortYear() {
        switch self {
        case .dayMonthYear:
            self = .dayMonthShortYear
        case .monthDayYear:
            self = .monthDayShortYear
        case .yearMonthDay:
            self = .shortYearMonthDay
        default:
            break
        }
    }
}

public extension Locale {
    func dateOrder() -> RomanDateFormatter {
        guard let formatter = DateFormatter.dateFormat(fromTemplate: "MMMMdY", options: 0, locale: self) else {
            return .dayMonthYear
        }

        if formatter.hasPrefix("Y") {
            return .yearMonthDay
        }

        if formatter.hasPrefix("M") {
            return .monthDayYear
        }

        return .dayMonthYear
    }
}

struct RomanDate {
    var day: String
    var month: String
    var year: String
    var shortYear: String

    func dateComponentsFor(dateFormatter: RomanDateFormatter) -> [String] {
        switch dateFormatter {
        case .dayMonth:
            return [day, month]
        case .monthDay:
            return [month, day]
        case .dayMonthYear:
            return [day, month, year]
        case .dayMonthShortYear:
            return [day, month, shortYear]
        case .monthDayYear:
            return [month, day, year]
        case .monthDayShortYear:
            return [month, day, shortYear]
        case .yearMonthDay:
            return [year, month, day]
        case .shortYearMonthDay:
            return [shortYear, month, day]
        }
    }
}

struct RomanDateConverter {
    private func convert(_ int: Int) -> String? {
        guard int > 0 else {
            return nil
        }

        var number = int

        let values = [("M", 1000), ("CM", 900), ("D", 500), ("CD", 400), ("C",100), ("XC", 90), ("L",50), ("XL",40), ("X",10), ("IX", 9), ("V",5),("IV",4), ("I",1)]

        var result = ""

        for (romanChar, arabicValue) in values {
            let count = number / arabicValue

            if count == 0 { continue }

            for _ in 1...count
            {
                result += romanChar
                number -= arabicValue
            }
        }

        return result
    }

    func convert(_ date: Date) -> RomanDate? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)

        guard let month = components.month else { return nil}
        guard let day = components.day else { return nil}
        guard let year = components.year else { return nil}
        let shortYear = year % 100

        guard let convertedDay = convert(day), let convertedMonth = convert(month), let convertedYear = convert(year), let convertedShortYear = convert(shortYear) else {
            return nil
        }

        let result = RomanDate(day: convertedDay, month: convertedMonth, year: convertedYear, shortYear: convertedShortYear)

        return result
    }
}
