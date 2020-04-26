//
//  PhotoCollectionViewCell.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/17/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
    }
}

extension PhotoCollectionViewCell: DataBindable {
    func bind(data: UIImage?) {
        guard let data = data else { return }
        
        imgView.image = data
    }
}
