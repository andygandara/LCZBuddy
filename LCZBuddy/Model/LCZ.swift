//
//  LCZ.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/11/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import Firebase

public struct LCZ: Codable {
    let id: String
    let lczType: LCZType
    let location: GeoPoint
    let cityState: String
    let dateTime: Date
}

public enum LCZType: Int, CaseIterable, Codable {
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
        case .lczA: return UIColor(red: 0, green: 0.5569, blue: 0.4745, alpha: 1.0) /* #008e79 */
        case .lczB: return UIColor(red: 1, green: 0, blue: 0.5137, alpha: 1.0) /* #ff0083 */
        case .lczC: return UIColor(red: 0.7804, green: 1, blue: 0, alpha: 1.0) /* #c7ff00 */
        case .lczD: return UIColor(red: 0, green: 0.7882, blue: 0.7216, alpha: 1.0) /* #00c9b8 */
        case .lczE: return UIColor(red: 0.7098, green: 0.5294, blue: 0, alpha: 1.0) /* #b58700 */
        case .lczF: return UIColor(red: 0.7686, green: 0, blue: 0.5098, alpha: 1.0) /* #c40082 */
        case .lczG: return UIColor(red: 0.5765, green: 0, blue: 0, alpha: 1.0) /* #930000 */
        }
    }
}
