//
//  HomeTableViewCell.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/11/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import UIKit

public class HomeTableViewCell: UITableViewCell {
    @IBOutlet var lczTypeBgView: UIView!
    @IBOutlet var lczTypeLabel: UILabel!
    @IBOutlet var cityStateLabel: UILabel!
    @IBOutlet var coordinateLabel: UILabel!
    @IBOutlet var dateTimeLabel: UILabel!
    
    public required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        lczTypeBgView.layer.cornerRadius = lczTypeBgView.frame.height / 2
    }
    
}

extension HomeTableViewCell: DataBindable {
    public func bind(data: LCZ?) {
        guard let data = data else { return }
        
        lczTypeBgView.backgroundColor = data.lczType.color
        lczTypeLabel.text = data.lczType.name
        cityStateLabel.text = data.cityState
        coordinateLabel.text = data.location.formatted()
        dateTimeLabel.text = data.dateTime.formatted()
        
    }
}
