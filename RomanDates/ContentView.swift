//
//  ContentView.swift
//  RomanDates
//
//  Created by Robert Clarke on 08/05/2020.
//  Copyright © 2020 Robert Clarke. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settings: UserSettings

    @ObservedObject private var romanDateViewModel = RomanDateViewModel()

    @State private var showingSettings = false

    var body: some View {
        VStack {
            Text(romanDateViewModel.convertDate(userSettings: settings))
                .font(.largeTitle)

            Form {
                Text("What date do you want to convert?")
                    .font(.headline)

                DatePicker("Please choose a date", selection: $romanDateViewModel.dateToConvert, displayedComponents:
                    .date)
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())

                Section {
                    Button(action: {
                        self.showingSettings = true
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: "gear")
                                .renderingMode(.original)
                            Text("Settings")
                        }
                    }

                }

            }


        }
        .sheet(isPresented: $showingSettings) {
            SettingsView().environmentObject(self.settings)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserSettings())
    }
}
