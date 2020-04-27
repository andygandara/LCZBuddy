//
//  GeoPoint+Extensions.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/26/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import Foundation
import Firebase

extension GeoPoint {
    func formatted() -> String? {
       return "\(latitude.truncate(to: 4)), \(longitude.truncate(to: 4))"
    }
}
