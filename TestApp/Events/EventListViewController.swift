//
//  EventListViewController.swift
//  TestApp
//
//  Created by Domini Valencia on 11/25/24.
//

import UIKit
import RealmSwift

class EventListViewController: UITableViewController {
    
    let realm = try! Realm()
    var events: Results<Event>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Event Log"
        fetchEvents()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 60  // or any reasonable default height
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func fetchEvents() {
        events = realm.objects(Event.self).sorted(byKeyPath: "timestamp", ascending: false)
        tableView.reloadData()
    }
    
    // MARK: - Table View DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let event = events[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        cell.textLabel?.text = "Button \(event.buttonId) pressed"
        cell.detailTextLabel?.text = "\(dateFormatter.string(from: event.timestamp))"
        
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
}
