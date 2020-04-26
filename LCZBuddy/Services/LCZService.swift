//
//  LCZService.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/13/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import Foundation

class LCZService {
    var lczs: [LCZModel] = []
    
    func fetchLCZs() -> [LCZModel] {
        lczs = [LCZModel(lczType: .lcz1),
                LCZModel(lczType: .lcz2),
                LCZModel(lczType: .lcz3),
                LCZModel(lczType: .lcz4),
                LCZModel(lczType: .lcz5),
                LCZModel(lczType: .lcz6),
                LCZModel(lczType: .lcz7),
                LCZModel(lczType: .lcz8),
                LCZModel(lczType: .lcz9),
                LCZModel(lczType: .lcz10),
                LCZModel(lczType: .lczA),
                LCZModel(lczType: .lczB),
                LCZModel(lczType: .lczC),
                LCZModel(lczType: .lczD),
                LCZModel(lczType: .lczE)]
        return lczs
    }
    
    func add(_ model: LCZModel) {
        lczs.append(model)
    }
}
