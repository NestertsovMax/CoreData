//
//  FriendListViewController.swift
//  CoreDataExample
//
//  Created by M1 on 09.09.2022.
//

import UIKit
import CoreData

class FriendListViewController: UITableViewController {
    
    private var friends: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Friend List"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    private func loadData() {
        let context = CoreDataManager.instance.persistentContainer.viewContext
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        do {
            friends = try context.fetch(request)
            tableView.reloadData()
        } catch {
            debugPrint("Fetching failed")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let item = friends[indexPath.row]
        cell.textLabel?.text = item.name
        if let birthDate = item.birthDate as? Date {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            cell.detailTextLabel?.text = formatter.string(from: birthDate)
        }
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let item = friends[indexPath.row]
        CoreDataManager.instance.persistentContainer.viewContext.delete(item)
        CoreDataManager.instance.saveContext()
        loadData()
    }
}
