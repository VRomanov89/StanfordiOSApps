//
//  Tweet+CoreDataProperties.swift
//  SmashTag
//
//  Created by Volodymyr Romanov on 7/26/16.
//  Copyright © 2016 Volodymyr Romanov. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Tweet {

    @NSManaged var text: String?
    @NSManaged var unique: String?
    @NSManaged var posted: NSDate?
    @NSManaged var tweeter: TwitterUser?

}
