//
//  UserViewController.swift
//  NailsByCarmoe
//
//  Created by Simon Carlsson on 23/09/15.
//  Copyright © 2015 Simon Carlsson. All rights reserved.
//

import UIKit
import CoreData
var currentUser = ""
class UserViewController: UIViewController, TableViewController, UITableViewDelegate UISearchResultsUpdating {
    
    var users = [String]()
    var filteredUsers = [String]()
    var resultSearchController = UISearchController()
    
    @IBAction func newUser(sender: AnyObject) {
        currentUser = "new"
        self.performSegueWithIdentifier("toUserFromMain", sender: self)
    }
    
    func viewDidLoad() {
        super.viewDidLoad()
        // Load users from database
        self.users.removeAll(keepCapacity: false)
        getUsers()
        // Search Bar
        resultSearchController = UISearchController(searchResultsController: nil)
        resultSearchController.searchResultsUpdater = self
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.sizeToFit()
        tableView.tableHeaderView = resultSearchController.searchBar
        tableView.reloadData()
        print(users)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSearchController.active {
            return filteredUsers.count
        } else {
            return users.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath) as UITableViewCell?
        
        if self.resultSearchController.active {
            cell!.textLabel?.text = self.filteredUsers[indexPath.row]
        }else {
            cell!.textLabel?.text = self.users[indexPath.row]
        }
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        currentUser = tableView.cellForRowAtIndexPath(indexPath)!.textLabel!.text!
        //self.performSegueWithIdentifier("userSeg", sender: self)
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.filteredUsers.removeAll(keepCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (self.users as NSArray).filteredArrayUsingPredicate(searchPredicate)
        self.filteredUsers = array as! [String]
        self.tableView.reloadData()
    }
    
    func getUsers(){
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "Costumers")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.executeFetchRequest(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let username = result.valueForKey("name") as? String {
                        users.append(username)
                    }
                }
            }
        } catch {
            print("Fetch Failed")
        }
    }

}
