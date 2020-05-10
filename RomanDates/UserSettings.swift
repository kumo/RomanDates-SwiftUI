//
//  UserSettings.swift
//  RomanDates
//
//  Created by Robert Clarke on 09/05/2020.
//  Copyright © 2020 Robert Clarke. All rights reserved.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var useDeviceDateOrder: Bool = UserDefaults.standard.bool(forKey: "useDeviceDateOrder") {
        didSet { UserDefaults.standard.set(self.useDeviceDateOrder, forKey: "useDeviceDateOrder") }
    }
    @Published var dateOrder: Int = UserDefaults.standard.integer(forKey: "dateOrder") {
        didSet { UserDefaults.standard.set(self.dateOrder, forKey: "dateOrder") }
    }
    @Published var showYear: Bool = UserDefaults.standard.bool(forKey: "showYear") {
        didSet { UserDefaults.standard.set(self.showYear, forKey: "showYear") }
    }
    @Published var symbolSeparator: Int = UserDefaults.standard.integer(forKey: "symbolSeparator") {
        didSet { UserDefaults.standard.set(self.symbolSeparator, forKey: "symbolSeparator") }
    }
}
