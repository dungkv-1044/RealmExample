//
//  TableViewController.swift
//  DemoRealm
//
//  Created by Khuat Van Dung on 9/1/17.
//  Copyright © 2017 Khuat Van Dung. All rights reserved.
//

import UIKit
import RealmSwift
import os.log
class TableViewController: UITableViewController {
    var realm: Realm?
    var humans: [Human] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaulRealmForUser(username: "Relation2")
        realm = try! Realm()
        queryAllHuman()
    }
    
    func setDefaulRealmForUser(username: String) {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent("\(username).realm")
        Realm.Configuration.defaultConfiguration = config
    }
    
    func queryAllHuman() {
        let allHuman  = realm?.objects(Human.self)
        for human in allHuman! {
            humans.append(human)
        }
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        humans = []
        queryAllHuman()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return humans.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = humans[indexPath.row].name
        let course = humans[indexPath.row].courses[1]
        print(course.name)
        if let faculty = humans[indexPath.row].faculty {
            print(faculty.name)
        }
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm?.write {
                realm?.delete(humans[indexPath.row])
            }
            humans.remove(at: indexPath.row)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let humanViewController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedHuman = sender as? UITableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedHuman) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedItem = humans[indexPath.row]
            humanViewController.h = selectedItem
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
}
