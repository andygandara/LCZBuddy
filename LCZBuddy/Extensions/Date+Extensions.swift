//
//  Date+Extensions.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/13/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import Foundation

extension Date {
    func formatted() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM dd, yyyy  hh:mm a"
        return dateFormatterPrint.string(from: self)
    }
}
