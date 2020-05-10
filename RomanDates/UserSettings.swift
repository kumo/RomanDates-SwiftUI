//
//  UserSettings.swift
//  RomanDates
//
//  Created by Robert Clarke on 09/05/2020.
//  Copyright © 2020 Robert Clarke. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class UserSettings: ObservableObject {
    
    @Published var useDeviceDateOrder: Bool {
        didSet {
            UserDefaults.standard.set(useDeviceDateOrder, forKey: "useDeviceDateOrder")
        }
    }
    
    @Published var dateOrder: Int {
        didSet {
            UserDefaults.standard.set(dateOrder, forKey: "dateOrder")
        }
    }
    
    @Published var showYear: Bool {
        didSet {
            UserDefaults.standard.set(showYear, forKey: "showYear")
        }
    }
    
    @Published var showFullYear: Bool {
        didSet {
            UserDefaults.standard.set(showFullYear, forKey: "showFullYear")
        }
    }
    
    @Published var symbolSeparator: Int {
        didSet {
            UserDefaults.standard.set(symbolSeparator, forKey: "symbolSeparator")
        }
    }
    
    init() {
        self.useDeviceDateOrder = UserDefaults.standard.object(forKey: "useDeviceDateOrder") as? Bool ?? true
        self.dateOrder = UserDefaults.standard.object(forKey: "dateOrder") as? Int ?? 1
        self.showYear = UserDefaults.standard.object(forKey: "showYear") as? Bool ?? true
        self.showFullYear = UserDefaults.standard.object(forKey: "showFullYear") as? Bool ?? true
        self.symbolSeparator = UserDefaults.standard.object(forKey: "symbolSeparator") as? Int ?? 3
    }
}
