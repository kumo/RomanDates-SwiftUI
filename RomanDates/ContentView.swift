//
//  ContentView.swift
//  RomanDates
//
//  Created by Robert Clarke on 08/05/2020.
//  Copyright © 2020 Robert Clarke. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var dateToConvert = Date()

    @State private var showingSettings = false

    var convertedDate: String {
        let result = dateToConvert.dateInRoman()

        return result.year + "-" + result.month + "-" + result.day
    }

    var body: some View {
        VStack {
            Text(convertedDate)
                .font(.largeTitle)

            Form {
                Text("What date do you want to convert?")
                    .font(.headline)

                DatePicker("Please choose a date", selection: $dateToConvert, displayedComponents:
                    .date)
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())

                Section {
                    Button(action: {
                        print("Edit button was tapped")
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
            SettingsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
