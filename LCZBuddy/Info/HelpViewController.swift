//
//  MoreInfoViewController.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/27/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import UIKit

class MoreInfoViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let helpService = HelpService()
    var descriptions: [LCZDescription] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "HelpTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HelpTableViewCell")
        descriptions = helpService.getDescriptions()
    }
}

extension MoreInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return descriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpTableViewCell", for: indexPath) as! HelpTableViewCell
        cell.bind(data: descriptions[indexPath.row])
        return cell
    }
}
