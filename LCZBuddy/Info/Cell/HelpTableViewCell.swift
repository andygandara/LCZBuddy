//
//  MoreInfoTableViewCell.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/28/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import UIKit

class MoreInfoTableViewCell: UITableViewCell {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension MoreInfoTableViewCell: DataBindable {
    func bind(data: LCZDescription?) {
        guard let data = data else { return }
        
        imgView.image = data.image
        nameLabel.text = data.name
        descriptionLabel.text = data.description
    }
}
