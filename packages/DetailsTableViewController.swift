//
//  DetailsTableViewController.swift
//  packages
//
//  Created by LOANER on 8/24/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

import UIKit

protocol PackageDetailsDelegate {
    func didEnterPackageDetails(barcode: String, employee: Employee)
}

class DetailsTableViewController: UITableViewController, ScanDelegate, EmployeeDelegate, UITextFieldDelegate {
    
    var delegate: PackageDetailsDelegate?
    var barCode: String?
    var selectedEmployee: Employee? {
        didSet {
            employeeTextField.text = selectedEmployee?.name
        }
    }
    
    @IBOutlet weak var employeeTextField: UITextField!
    @IBOutlet weak var senderTextField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set save button to the top right
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @IBAction func dismiss(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        // Send delegate message
        delegate?.didEnterPackageDetails(barCode!, employee: selectedEmployee!)
        
        // Dismiss
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showBarcodeCamera" {
            let navVC = segue.destinationViewController as! UINavigationController
            let destinationVC = navVC.topViewController as! ScanObjcViewController
            destinationVC.delegate = self
        } else if segue.identifier == "showEmployeeList" {
            let navVC = segue.destinationViewController as! UINavigationController
            let destinationVC = navVC.topViewController as! EmployeeTableViewController
            destinationVC.delegate = self
        }
    }
    
    func checkSaveButtonStatus() {
        if let _ = barCode, let _ = selectedEmployee {
            saveButton.enabled = true
        } else {
            saveButton.enabled = false
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        senderTextField.resignFirstResponder()
        
        return true
    }
    
    // MARK: - Scan Delegate
    func didScanBarCode(barCode: String!) {
        self.barCode = barCode
        self.tableView.reloadData()
        
        checkSaveButtonStatus()
    }
    
    // MARK: - EmployeeDelegate
    func didPickEmployee(employee: Employee) {
        selectedEmployee = employee
        
        checkSaveButtonStatus()
    }
    
    // Mark: - UITableView Delegate
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let barCode = barCode {
            return "Package #\(barCode)"
        }
        
        return ""
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2 {
            // Show camera
        }
    }

}
