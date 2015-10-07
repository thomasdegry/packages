//
//  ContactsStore.swift
//  packages
//
//  Created by LOANER on 10/6/15.
//  Copyright © 2015 Thomas Degry. All rights reserved.
//

import Foundation
import CoreData

class ContactStore {
    var context = NSManagedObjectContext()
    
    init() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        context = appDelegate.managedObjectContext
    }
}