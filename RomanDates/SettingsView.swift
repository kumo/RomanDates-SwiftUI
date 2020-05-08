//
//  SettingsView.swift
//  RomanDates
//
//  Created by Robert Clarke on 08/05/2020.
//  Copyright © 2020 Robert Clarke. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @State private var dateOrder: Int = 1
    @State private var dateDeviceSettings: Bool = false
    @State private var showYear: Bool = false
    @State private var symbolSeparator: Int = 1

    private var symbolOptions = ["·", "–", "/", " "]

    var body: some View {
        Form {
            Section(header: Text("DATE ORDER")) {

                Toggle("Use device settings", isOn: $dateDeviceSettings)

                Picker(
                    selection: $dateOrder,
                    label: Text("date order"),
                    content: {
                        if (showYear) {
                            Text("Day-M-Y").tag(1)
                            Text("Month-D-Y").tag(2)
                            Text("Year-M-D").tag(3)
                        } else {
                            Text("Day–Month").tag(1)
                            Text("Month–Day").tag(2)
                        }
                })
                    .pickerStyle(SegmentedPickerStyle())
                    .disabled(dateDeviceSettings)
            }

            Section(header: Text("YEAR"), footer: Text("Should the year be shown and should it appear in full (e.g. 2020 or 20)")) {

                Toggle("Show year", isOn: $showYear)
                Text("Show year in full")
            }

            Section(header: Text("Separator Symbol")) {
                Picker(
                    selection: $symbolSeparator,
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
        SettingsView()
    }
}
