//
//  Contact+CoreDataProperties.swift
//  packages
//
//  Created by LOANER on 10/6/15.
//  Copyright © 2015 Thomas Degry. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Contact {

    @NSManaged var username: String?
    @NSManaged var email: String?
    @NSManaged var firstname: String?
    @NSManaged var lastname: String?
    @NSManaged var slug: String?
    @NSManaged var team: NSNumber?
    @NSManaged var title: String?
    @NSManaged var avatar: String?
    @NSManaged var birthday: NSDate?

}
