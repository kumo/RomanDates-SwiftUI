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
        guard let convertedDateParts = RomanDateConverter().convert(dateToConvert) else {
            return "unknown error"
        }

        let result = convertedDateParts.dateComponentsFor(dateFormatter: userSettings.dateFormatter).joined(separator: symbolOptions[userSettings.symbolSeparator])

        return result
    }
}
