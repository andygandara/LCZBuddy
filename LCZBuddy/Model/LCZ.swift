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
//    let images: [Data]?
    
//    init(model: LCZModel) {
//        id = model.id
//        lczType = model.lczType ?? .unknown
//        location = Coordinate(geoPoint: model.location)
//        cityState = model.cityState ?? ""
//        dateTime = model.dateTime ?? Date()
//        images = model.images ?? []
//    }
    
//    init(id: String, lczType: LCZType, location: Coordinate, cityState: String, dateTime: Date, images: [Image]) {
//        self.id = id
//        self.lczType = lczType
//        self.location = location
//        self.cityState = cityState
//        self.dateTime = dateTime
////        self.images = images
//    }
    
//    init(lczType: LCZType) {
//        self.lczType = lczType
//        location = CLLocationCoordinate2D(
//            latitude: Double.random(in: 32...36),
//            longitude: Double.random(in: -120...(-108)))
//        cityState = "Tempe, AZ"
//        dateTime = Date() - TimeInterval(Int.random(in: 0...14))
//        images = []
//    }
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

struct Coordinate {
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(geoPoint: GeoPoint?) {
        latitude = (geoPoint?.latitude ?? 0.0) as Double
        longitude = (geoPoint?.longitude ?? 0.0) as Double
    }
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        geopoint = try values.decode(GeoPoint.self, forKey: .geopoint)
//        latitude = geopoint?.latitude ?? 0
//        longitude = geopoint?.longitude ?? 0
//        // latitude = try values.decode(Double.self, forKey: .latitude)
//        // longitude = try values.decode(Double.self, forKey: .longitude)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
////        try container.encode(geopoint, forKey: .geopoint)
//        try container.encode(latitude, forKey: .latitude)
//        try container.encode(longitude, forKey: .longitude)
//    }

    func locationCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude,
                                      longitude: self.longitude)
    }
}

struct Image: Codable {
    let imageData: Data?
    
    init(_ image: UIImage) { self.imageData = image.pngData() }

    func getImage() -> UIImage? {
        guard let imageData = self.imageData else { return nil }
        return UIImage(data: imageData)
    }
}
