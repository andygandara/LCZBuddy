//
//  InfoViewController.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/27/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    let helpService = HelpService()
    var descriptions: [LCZDescription] = []
    var sections: [[LCZDescription]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "InfoTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "InfoTableViewCell")
        setupSections()
    }
    
    func setupSections() {
        descriptions = helpService.getDescriptions()
        sections.append(descriptions.filter { $0.type == .built })
        sections.append(descriptions.filter { $0.type == .landCover })
    }
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Built types" : "Land cover types"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell
        cell.bind(data: sections[indexPath.section][indexPath.row])
        return cell
    }
}
