//
//  PackageListTableViewController.swift
//  packages
//
//  Created by LOANER on 8/18/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

import UIKit

struct PackageInformation {
    var recipient = ""
    var meta = ""
    var tracking = ""
}

class PackageListTableViewController: UITableViewController, PackageDetailsDelegate {
    
    @IBOutlet weak var statusControl: UISegmentedControl!
    var openPackages = [PackageInformation]()
    var pickedUpPackages = [PackageInformation]()
    
    let emailHelper = EmailHelper()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func didChangeStatus(sender: UISegmentedControl) {
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetails" {
            let navVC = segue.destinationViewController as! UINavigationController
            let destinationVC = navVC.topViewController as! DetailsTableViewController
            
            destinationVC.delegate = self
        }
    }
    
    func didEnterPackageDetails(barcode: String, employee: Employee) {
        let newPackage = PackageInformation(recipient: employee.name, meta: "", tracking: barcode)
        
        // Store in array
        openPackages.append(newPackage)
        
        // Reload tableview
        self.tableView.reloadData()
        
        // Send out email
        emailHelper.sendPickUpEmailTo(employee)
    }


    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusControl.selectedSegmentIndex == 0 ? openPackages.count : pickedUpPackages.count
    }

    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let pickUpAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal,
            title: "Pick Up") { (action, indexPath) -> Void in
                let package = self.openPackages[indexPath.row]
                
                // Delete in open array
                self.openPackages.removeAtIndex(indexPath.row)
                
                // Delete from tableView
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                
                // Add in pickedUp array
                self.pickedUpPackages.append(package)
        }
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal,
            title: "Delete") { (action, indexPath) -> Void in
                let package = self.openPackages[indexPath.row]
                println("Delete package for \(package.recipient)")
        }
        
        deleteAction.backgroundColor = UIColor.redColor()
        
        let setOpen = UITableViewRowAction(style: UITableViewRowActionStyle.Normal,
            title: "Reopen") { (action, indexPath) -> Void in
                let package = self.pickedUpPackages[indexPath.row]
                
                // Delete in open array
                self.pickedUpPackages.removeAtIndex(indexPath.row)
                
                // Delete from tableView
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                
                // Add in pickedUp array
                self.openPackages.append(package)
        }

        return self.statusControl.selectedSegmentIndex == 0 ? [pickUpAction, deleteAction] : [setOpen, deleteAction]
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("packageCell", forIndexPath: indexPath) as! PackageTableViewCell
        
        // Get te package at index from the packages array
        // and pass it to the cell
        let packageArray = statusControl.selectedSegmentIndex == 0 ? openPackages : pickedUpPackages
        cell.packageInformation = packageArray[indexPath.row]
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
