//
//  LCZDescription.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/27/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import Foundation
import UIKit

enum LCZCategory {
    case built
    case landCover
}

struct LCZDescription {
    let name: String
    let type: LCZCategory
    let description: String
    let image: UIImage
}

