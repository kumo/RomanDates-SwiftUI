//
//  Converters.swift
//  RomanDates
//
//  Created by Robert Clarke on 08/05/2020.
//  Copyright © 2020 Robert Clarke. All rights reserved.
//

import Foundation

public enum DateOrder: Int {
    case dayFirst = 1, monthFirst, yearFirst
}

public extension Locale {

    func dateOrder() -> DateOrder {
        guard let formatter = DateFormatter.dateFormat(fromTemplate: "MMMMdY", options: 0, locale: self) else {
            return .dayFirst
        }

        if formatter.hasPrefix("Y") {
            return .yearFirst
        }

        if formatter.hasPrefix("M") {
            return .monthFirst
        }

        return .dayFirst
    }
}

enum RomanDateError: Error {
    case invalidDate
}
struct ConvertedDate {
    var day: String
    var month: String
    var year: String
    var shortYear: String
}

struct RomanDateConverter {
    func convertInt(_ int: Int) -> String? {
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

    func convertDate(_ date: Date) -> ConvertedDate? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)

        guard let month = components.month else { return nil}
        guard let day = components.day else { return nil}
        guard let year = components.year else { return nil}
        let shortYear = year % 100

        let result = ConvertedDate(day: convertInt(day)!, month: convertInt(month)!, year: convertInt(year)!, shortYear: convertInt(shortYear)!)

        return result
    }
}
extension Int {
    func toRoman() -> String? {
        guard self > 0 else {
            return nil
        }

        var number = self

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
}

extension Date {
    func dateInRoman() -> (day:String, month:String, year:String, shortYear:String?) {

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)

        let month = components.month
        let day = components.day
        let year = components.year
        let shortYear = year! % 100

        return (day!.toRoman()!, month!.toRoman()!, year!.toRoman()!, shortYear.toRoman())
    }
}
