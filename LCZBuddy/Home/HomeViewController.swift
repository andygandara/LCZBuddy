//
//  HomeViewController.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/1/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    var lczRecords: [LCZModel] = [] {
        didSet { tableView.reloadData() }
    }
    
    let lczService = LCZService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchLCZRecords()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "HomeToDetail":
            let viewController = segue.destination as! DetailViewController
            guard let selectedIndexPathRow = tableView.indexPathForSelectedRow?.row else { return }
            let selectedModel = lczRecords[selectedIndexPathRow]
            viewController.model = selectedModel
        default: break
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "HomeToAdd", sender: self)
    }
    
    @IBAction func segmentedControlChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0: lczRecords.sort { $0.lczType.rawValue < $1.lczType.rawValue }
        case 1: lczRecords.sort { $0.dateTime < $1.dateTime }
        default: break
        }
        tableView.reloadData()
    }
    
    func fetchLCZRecords() {
        lczRecords = lczService.fetchLCZs()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lczRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.bind(data: lczRecords[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "HomeToDetail", sender: self)
    }
    
}
