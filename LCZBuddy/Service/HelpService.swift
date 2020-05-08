//
//  HelpService.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/28/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import Foundation
import UIKit

class HelpService {
    private let descriptions: [LCZDescription] = [
        // 1
        LCZDescription(name: "1. Compact high-rise",
                       type: .built,
                       description: "Dense mix of tall buildings to tens of stories. Few or no trees. Land cover mostly paved. Concrete, steel, stone, and glass construction materials.",
                       image: UIImage(named: "lcz1") ?? UIImage()),
        // 2
        LCZDescription(name: "2. Compact mid-rise",
                       type: .built,
                       description: "Dense mix of midrise buildings (3–9 stories). Few or no trees. Land cover mostly paved. Stone, brick, tile, and concrete construction materials.",
                       image: UIImage(named: "lcz2") ?? UIImage()),
        // 3
        LCZDescription(name: "3. Compact low-rise",
                       type: .built,
                       description: "Dense mix of low-rise buildings (1–3 stories). Few or no trees. Land cover mostly paved. Stone, brick, tile, and concrete construction materials.",
                       image: UIImage(named: "lcz3") ?? UIImage()),
        // 4
        LCZDescription(name: "4. Open high-rise",
                       type: .built,
                       description: "Open arrangement of tall buildings to tens of stories. Abundance of pervious land cover (low plants, scattered trees). Concrete, steel, stone, and glass construction materials.",
                       image: UIImage(named: "lcz4") ?? UIImage()),
        // 5
        LCZDescription(name: "5. Open midrise",
                       type: .built,
                       description: "Open arrangement of midrise buildings (3–9 stories). Abundance of pervious land cover (low plants, scattered trees). Concrete, steel, stone, and glass construction materials.",
                       image: UIImage(named: "lcz5") ?? UIImage()),
        // 6
        LCZDescription(name: "6. Open low-rise",
                       type: .built,
                       description: "Open arrangement of low-rise buildings (1–3 stories). Abundance of pervious land cover (low plants, scattered trees). Wood, brick, stone, tile, and concrete construction materials.",
                       image: UIImage(named: "lcz6") ?? UIImage()),
        // 7
        LCZDescription(name: "7. Lightweight low-rise",
                       type: .built,
                       description: "Dense mix of single-story buildings. Few or no trees. Land cover mostly hard-packed. Lightweight construction materials (e.g., wood, thatch, corrugated metal).",
                       image: UIImage(named: "lcz7") ?? UIImage()),
        // 8
        LCZDescription(name: "8. Large low-rise",
                       type: .built,
                       description: "Open arrangement of large low-rise buildings (1–3 stories). Few or no trees. Land cover mostly paved. Steel, concrete, metal, and stone construction materials.",
                       image: UIImage(named: "lcz8") ?? UIImage()),
        // 9
        LCZDescription(name: "9. Sparsely built",
                       type: .built,
                       description: "Sparse arrangement of small or medium-sized buildings in a natural setting. Abundance of pervious land cover (low plants, scattered trees).",
                       image: UIImage(named: "lcz9") ?? UIImage()),
        // 10
        LCZDescription(name: "10. Heavy industry",
                       type: .built,
                       description: "Low-rise and midrise industrial struc- tures (towers, tanks, stacks). Few or no trees. Land cover mostly paved or hard-packed. Metal, steel, and concrete construction materials.",
                       image: UIImage(named: "lcz10") ?? UIImage()),
        // A
        LCZDescription(name: "A. Dense trees",
                       type: .landCover,
                       description: "Heavily wooded landscape of deciduous and/or evergreen trees. Land cover mostly pervious (low plants). Zone function is natural forest, tree cultivation, or urban park.",
                       image: UIImage(named: "lczA") ?? UIImage()),
        // B
        LCZDescription(name: "B. Scattered trees",
                       type: .landCover,
                       description: "Lightly wooded landscape of deciduous and/or evergreen trees. Land cover mostly pervious (low plants). Zone function is natural forest, tree cultivation, or urban park.",
                       image: UIImage(named: "lczB") ?? UIImage()),
        // C
        LCZDescription(name: "C. Bush, scrub",
                       type: .landCover,
                       description: "Open arrangement of bushes, shrubs, and short, woody trees. Land cover mostly pervious (bare soil or sand). Zone function is natural scrubland or agriculture.",
                       image: UIImage(named: "lczC") ?? UIImage()),
        // D
        LCZDescription(name: "D. Low plants",
                       type: .landCover,
                       description: "Featureless landscape of grass or herbaceous plants/crops. Few or no trees. Zone function is natural grassland, agriculture, or urban park.",
                       image: UIImage(named: "lczD") ?? UIImage()),
        // E
        LCZDescription(name: "E. Bare rock or paved",
                       type: .landCover,
                       description: "Featureless landscape of rock or paved cover. Few or no trees or plants. Zone function is natural desert (rock) or urban transportation.",
                       image: UIImage(named: "lczE") ?? UIImage()),
        // F
        LCZDescription(name: "F. Bare soil or sand",
                       type: .landCover,
                       description: "Featureless landscape of soil or sand cover. Few or no trees or plants. Zone function is natural desert or agriculture.",
                       image: UIImage(named: "lczF") ?? UIImage()),
        // G
        LCZDescription(name: "G. Water",
                       type: .landCover,
                       description: "Large, open water bodies such as seas and lakes, or small bodies such as rivers, reservoirs, and lagoons.",
                       image: UIImage(named: "lczG") ?? UIImage())
    ]
    
    func getDescriptions() -> [LCZDescription] {
        return descriptions
    }
}
