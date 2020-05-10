//
//  RomanDateViewModel.swift
//  RomanDates
//
//  Created by Robert Clarke on 10/05/2020.
//  Copyright © 2020 Robert Clarke. All rights reserved.
//

import SwiftUI

class RomanDateViewModel: ObservableObject {
    @Published var dateToConvert = Date()

    private var symbolOptions = ["·", "–", "/", " "]

    func convertDate(userSettings: UserSettings) -> String {
        guard let convertedDateParts = RomanDateConverter().convertDate(dateToConvert) else {
            return "unknown error"
        }

        var order = userSettings.dateOrder
        let combinedParts: [String]

        if (userSettings.useDeviceDateOrder) {
            print(Locale.current.dateOrder())
            order = Locale.current.dateOrder().rawValue
        }

        switch order {
        case DateOrder.dayFirst.rawValue:
            combinedParts = [convertedDateParts.day, convertedDateParts.month, userSettings.showYear ? (userSettings.showFullYear ? convertedDateParts.year : convertedDateParts.shortYear) : ""]
        case 2:
            combinedParts = [convertedDateParts.month, convertedDateParts.day, userSettings.showYear ? (userSettings.showFullYear ? convertedDateParts.year : convertedDateParts.shortYear) : ""]
        case 3:
            if (userSettings.showYear == false) {
                combinedParts = [convertedDateParts.month, convertedDateParts.day]
            } else {
                combinedParts = [userSettings.showFullYear ?
                    convertedDateParts.year : convertedDateParts.shortYear, convertedDateParts.month, convertedDateParts.day]
            }
        default:
            combinedParts = ["unknown", "error"]
        }

        return combinedParts.joined(separator: symbolOptions[userSettings.symbolSeparator])
    }


    var convertedDate: String {
        get {
            guard let result = RomanDateConverter().convertDate(dateToConvert) else {
                return "unknown error"
            }

            return result.year + "-" + result.month + "-" + result.day
        }

    }
}
