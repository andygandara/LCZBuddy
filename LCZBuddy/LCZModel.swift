//
//  LCZModel.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/11/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

public struct LCZModel {
    let lczType: LCZType
    let location: CLLocationCoordinate2D
    let cityState: String
    let dateTime: Date
    let images: [UIImage]
    
    init(lczType: LCZType, location: CLLocationCoordinate2D, cityState: String, dateTime: Date, images: [UIImage]) {
        self.lczType = lczType
        self.location = location
        self.cityState = cityState
        self.dateTime = dateTime
        self.images = images
    }
    
    init(lczType: LCZType) {
        self.lczType = lczType
        location = CLLocationCoordinate2D(
            latitude: Double.random(in: 32...36),
            longitude: Double.random(in: -120...(-108)))
        cityState = "Tempe, AZ"
        dateTime = Date() - TimeInterval(Int.random(in: 0...14))
        images = []
    }
}

public enum LCZType: Int, CaseIterable {
    case lcz1
    case lcz2
    case lcz3
    case lcz4
    case lcz5
    case lcz6
    case lcz7
    case lcz8
    case lcz9
    case lcz10
    case lczA
    case lczB
    case lczC
    case lczD
    case lczE
    case lczF
    case lczG
    
    var name: String {
        switch self {
        case .lcz1: return "1"
        case .lcz2: return "2"
        case .lcz3: return "3"
        case .lcz4: return "4"
        case .lcz5: return "5"
        case .lcz6: return "6"
        case .lcz7: return "7"
        case .lcz8: return "8"
        case .lcz9: return "9"
        case .lcz10: return "10"
        case .lczA: return "A"
        case .lczB: return "B"
        case .lczC: return "C"
        case .lczD: return "D"
        case .lczE: return "E"
        case .lczF: return "F"
        case .lczG: return "G"
        }
    }
    
    var color: UIColor {
        switch self {
        case .lcz1: return .systemBlue
        case .lcz2: return .systemGreen
        case .lcz3: return .systemRed
        case .lcz4: return .systemPink
        case .lcz5: return .systemPurple
        case .lcz6: return .systemTeal
        case .lcz7: return .systemYellow
        case .lcz8: return .systemOrange
        case .lcz9: return .systemIndigo
        case .lcz10: return .systemGray
        case .lczA: return .systemBlue
        case .lczB: return .systemBlue
        case .lczC: return .systemBlue
        case .lczD: return .systemBlue
        case .lczE: return .systemBlue
        case .lczF: return .systemBlue
        case .lczG: return .systemBlue
        }
    }
}
