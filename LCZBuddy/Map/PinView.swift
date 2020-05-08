//
//  PinView.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/27/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import Foundation
import UIKit

class PinView: UIView, NibLoadable {
    @IBOutlet var lczLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib()
    }
}

extension PinView: DataBindable {
    func bind(data: LCZ?) {
        guard let data = data else { return }

        lczLabel.text = data.lczType.name
        backgroundColor = data.lczType.color
    }
}
