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
    
    var refreshControl = UIRefreshControl()
    
    var lczs: [LCZ] = []
    let lczService = LCZService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRefreshControl()
        fetchLCZRecords()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didAddLCZ),
                                               name: Notification.Name(rawValue: "didAddLCZ"),
                                               object: nil)
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
            let selectedModel = lczs[selectedIndexPathRow]
            viewController.model = selectedModel
        default: break
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "HomeToAdd", sender: self)
    }
    
    @IBAction func segmentedControlChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0: lczs.sort { $0.lczType.rawValue < $1.lczType.rawValue }
        case 1: lczs.sort { $0.dateTime > $1.dateTime }
        default: break
        }
        tableView.reloadData()
    }
    
    @objc private func didAddLCZ(notification: NSNotification) {
        fetchLCZRecords()
    }
    
    func fetchLCZRecords() {
        refreshControl.beginRefreshing()
        lczService.fetchLCZs { lczs in
            guard let lczs = lczs else { return }
            self.lczs = lczs.sorted { self.segmentedControl.selectedSegmentIndex == 0
                ? ($0.lczType.rawValue < $1.lczType.rawValue)
                : ($0.dateTime > $1.dateTime) }
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
    }
    
    func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        fetchLCZRecords()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lczs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.bind(data: lczs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "HomeToDetail", sender: self)
    }
    
}
