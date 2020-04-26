//
//  CLLocationCoordinate2D+Extensions.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/13/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D {
    func formatted() -> String? {
       return "\(latitude.truncate(to: 4)), \(longitude.truncate(to: 4))"
    }
}
