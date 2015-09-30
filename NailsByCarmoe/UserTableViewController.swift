//
//  UserTableViewController.swift
//  NailsByCarmoe
//
//  Created by Simon Carlsson on 24/09/15.
//  Copyright © 2015 Simon Carlsson. All rights reserved.
//

import UIKit
import CoreData

var currentDate = ""

extension UITableViewCell {
    /// Search up the view hierarchy of the table view cell to find the containing table view
    var tableView: UITableView? {
        get {
            var table: UIView? = superview
            while !(table is UITableView) && table != nil {
                table = table?.superview
            }
            
            return table as? UITableView
        }
    }
}

class UserTableViewController: UITableViewController, UITextFieldDelegate {

    var nameHidden = true
    var numberHidden = true
    var emailHidden = true
    
    var name = ""
    var number = ""
    var email = ""
    var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if currentUser != "new" {
            let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context: NSManagedObjectContext = appDel.managedObjectContext
            var request = NSFetchRequest(entityName: "Costumers")
            request.predicate = NSPredicate(format: "name = %@", currentUser)
            request.returnsObjectsAsFaults = false
            do {
                let results = try context.executeFetchRequest(request)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let username = result.valueForKey("name") as? String{
                            name = username
                        }
                        if let useremail = result.valueForKey("mail") as? String{
                            email = useremail
                        }
                        if let usertelephone = result.valueForKey("telephone") as? String{
                            number = usertelephone
                        }
                        if let usertext = result.valueForKey("text") as? String{
                            text = usertext
                        }
                    }
                }
            } catch {
                print("Fetch Failed")
            }
            
            tableView.reloadData()
        }
        
        tableView.estimatedRowHeight = 44.0 // Replace with your actual estimation
        // Automatic dimensions to tell the table view to use dynamic height
        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.reloadData()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 {
            return 5
        } else if section < 3 {
            return 2
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: (UITableView!), titleForHeaderInSection section: Int) -> String?{
        
        if section == 0 {
            return "Navn"
        } else if section == 1 {
            return "Telefon"
        } else if section == 2 {
            return "Email"
        } else if section == 3 {
            return "Noter"
        } else if section == 4 {
            return "Tider"
        } else {
            return "Fejl"
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // let cell = tableView.dequeueReusableCellWithIdentifier("uCell", forIndexPath: indexPath)

        // Configure the cell...
        //print(indexPath.row)
        //print(indexPath.section)
        
        if indexPath.section == 3 {
            
           let tcell: TableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cellText", forIndexPath: indexPath) as! TableViewCell
            tcell.TextViewOutlet.text = "DETTE ER EN TEST"
            
            return tcell
        } else if indexPath.section < 3 && indexPath.row == 1{
            
            let fcell: TextFieldCell = self.tableView.dequeueReusableCellWithIdentifier("cellField", forIndexPath: indexPath) as! TextFieldCell
            
            if indexPath.section == 0 {
                fcell.TextFieldOut.placeholder = "Skriv Navn"
                fcell.TextFieldOut.text = name
                fcell.TextFieldOut.tag = 0
            } else if indexPath.section == 1 {
                fcell.TextFieldOut.placeholder = "Skriv Nummer"
                fcell.TextFieldOut.keyboardType = UIKeyboardType.PhonePad
                fcell.TextFieldOut.text = number
                fcell.TextFieldOut.tag = 1
            } else {
                fcell.TextFieldOut.placeholder = "Skriv Email"
                fcell.TextFieldOut.keyboardType = UIKeyboardType.EmailAddress
                fcell.TextFieldOut.text = email
                fcell.TextFieldOut.tag = 2
            }
            
            return fcell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("uCell", forIndexPath: indexPath)
            if indexPath.section == 0 {
                cell.textLabel?.text = name
            } else if indexPath.section == 1 {
                cell.textLabel?.text = number
            } else if indexPath.section == 2 {
                cell.textLabel?.text = email
            }
            return cell
        }
        
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            toggleTextField("name")
        } else if indexPath.section == 1 && indexPath.row == 0 {
            toggleTextField("number")
        } else if indexPath.section == 2 && indexPath.row == 0 {
            toggleTextField("email")
        }
    }
    
    func toggleTextField(toggle: String) {
        
        if toggle == "name"{
        
            nameHidden = !nameHidden
            numberHidden = true
            emailHidden = true
            
        } else if toggle == "number" {
            nameHidden = true
            numberHidden = !numberHidden
            emailHidden = true
        } else if toggle == "email" {
            nameHidden = true
            numberHidden = true
            emailHidden = !emailHidden
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if nameHidden && indexPath.section == 0 && indexPath.row == 1 {
            return 0
        } else if numberHidden && indexPath.section == 1 && indexPath.row == 1 {
            return 0
        } else if emailHidden && indexPath.section == 2 && indexPath.row == 1 {
            return 0
        }
        else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    
}
