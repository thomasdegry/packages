//
//  DetailsTableViewController.swift
//  packages
//
//  Created by LOANER on 8/24/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    
    var barCode: String?
    @IBOutlet weak var senderTextField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set save button to the top right
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    // Mark: - UITableView Delegate
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let barCode = barCode {
            return "Package #\(barCode)"
        }
        
        return ""
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            // Show contacts list
        } else  if indexPath.row == 2 {
            // Show camera
        }
    }

}
