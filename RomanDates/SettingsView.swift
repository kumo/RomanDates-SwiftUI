//
//  SettingsView.swift
//  RomanDates
//
//  Created by Robert Clarke on 08/05/2020.
//  Copyright © 2020 Robert Clarke. All rights reserved.
//

import SwiftUI

// what I want is to have the core stuff for creating a piece of text with the date in roman numerals, the symbol separator, and the year formatting, done in another reusable thing. But, this thing can calculate the parts of a date, but not format it. So is that fine?

class PreviewViewModel: ObservableObject {
    private var symbolOptions = ["·", "–", "/", " "]

    func previewConversion(userSettings: UserSettings) -> String {
        var result = ""

        if (userSettings.useDeviceDateOrder) {
            result += "(device settings)"
        } else {
            result += "(manual order)"
        }

        result += " XII"
        result += symbolOptions[userSettings.symbolSeparator]
        result += "XII"

        if (userSettings.showYear) {
            result += symbolOptions[userSettings.symbolSeparator]
            if (userSettings.showFullYear) {
                result += "MMXII"
            } else {
                result += "XII"
            }
        }

        return result
    }
}

struct SettingsView: View {
    @EnvironmentObject var settings: UserSettings
    @ObservedObject private var previewViewModel = PreviewViewModel()

    private var symbolOptions = ["·", "–", "/", " "]

    var body: some View {
        Form {
            Section(footer: Text("Preview")) {
                HStack {
                    // I don't understand exactly how it works that this Text is updated everytime the settings change
                    Text(previewViewModel.previewConversion(userSettings: settings))
                }
            }

            // TODO: either hide the picker or show the current device settings instead
            Section(header: Text("DATE ORDER")) {

                Toggle("Use device settings", isOn: $settings.useDeviceDateOrder)

                //if (settings.useDeviceDateOrder == false) {
                Picker(
                    selection: $settings.dateOrder,
                    label: Text("date order"),
                    content: {
                        if (settings.showYear) {
                            Text("Day-M-Y").tag(0)
                            Text("Month-D-Y").tag(1)
                            Text("Year-M-D").tag(2)
                        } else {
                            Text("Day–Month").tag(0)
                            Text("Month–Day").tag(1)
                        }
                })
                    .pickerStyle(SegmentedPickerStyle())
                    .disabled(settings.useDeviceDateOrder)
                //}
            }

            Section(header: Text("YEAR"), footer: Text("Should the year be shown and should it appear in full (e.g. 2020 or 20)")) {

                Toggle("Show year", isOn: $settings.showYear)
                Toggle("Show year in full", isOn: $settings.showFullYear)
                    .disabled(settings.showYear == false)

            }

            Section(header: Text("SEPARATOR SYMBOL")) {
                Picker(
                    selection: $settings.symbolSeparator,
                    label: Text("symbol separator"),
                    content: {
                        ForEach(0..<symbolOptions.count) {
                            Text(self.symbolOptions[$0])
                        }
                })
                    .pickerStyle(SegmentedPickerStyle())

            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(UserSettings())
    }
}
