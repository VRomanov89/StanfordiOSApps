//
//  TweetersTableViewController.swift
//  SmashTag
//
//  Created by Volodymyr Romanov on 7/26/16.
//  Copyright © 2016 Volodymyr Romanov. All rights reserved.
//

import UIKit
import CoreData

class TweetersTableViewController: CoreDataTableViewController {
    
    //MODEL
    var mention: String?
    var managedObjectContext: NSManagedObjectContext? {
        didSet {
            updateUI()
        }
    }
    private func updateUI () {
        if let context = managedObjectContext where mention?.characters.count > 0 {
            let request = NSFetchRequest(entityName: "TwitterUser")
            request.predicate = NSPredicate(format: "any tweets.text contains[c] %@", mention!)
            request.sortDescriptors = [NSSortDescriptor(key: "screenName", ascending: true)]
            self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        } else {
            fetchedResultsController = nil
        }
    }
    
    override func viewDidLoad() {
        print("test1")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("test1")
        let cell = tableView.dequeueReusableCellWithIdentifier("TwitterUserCell", forIndexPath: indexPath)

        if let twitterUser = fetchedResultsController?.objectAtIndexPath(indexPath) as? TwitterUser {
            
            var screenName: String?
            twitterUser.managedObjectContext?.performBlockAndWait {
                screenName = twitterUser.screenName
            }
            cell.textLabel?.text = screenName
        }

        return cell
    }


}
