//
//  SettingsView.swift
//  RomanDates
//
//  Created by Robert Clarke on 08/05/2020.
//  Copyright © 2020 Robert Clarke. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: UserSettings

    private var symbolOptions = ["·", "–", "/", " "]

    var body: some View {
        Form {
            Section(footer: Text("Preview")) {
                HStack {
                    Text("XII")
                    Text(symbolOptions[settings.symbolSeparator])
                    Text("XII")

                    if (settings.showYear) {
                        Text(symbolOptions[settings.symbolSeparator])
                        Text("MMXII")
                    }
                }
            }

            Section(header: Text("DATE ORDER")) {

                Toggle("Use device settings", isOn: $settings.useDeviceDateOrder)

                Picker(
                    selection: $settings.dateOrder,
                    label: Text("date order"),
                    content: {
                        if (settings.showYear) {
                            Text("Day-M-Y").tag(1)
                            Text("Month-D-Y").tag(2)
                            Text("Year-M-D").tag(3)
                        } else {
                            Text("Day–Month").tag(1)
                            Text("Month–Day").tag(2)
                        }
                })
                    .pickerStyle(SegmentedPickerStyle())
                    .disabled(settings.useDeviceDateOrder)
            }

            Section(header: Text("YEAR"), footer: Text("Should the year be shown and should it appear in full (e.g. 2020 or 20)")) {

                Toggle("Show year", isOn: $settings.showYear)
                Text("Show year in full")
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
