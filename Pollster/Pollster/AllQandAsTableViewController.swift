//
//  AllQandAsTableViewController.swift
//  Pollster
//
//  Created by Volodymyr Romanov on 7/28/16.
//  Copyright © 2016 Volodymyr Romanov. All rights reserved.
//

import UIKit
import CloudKit

class AllQandAsTableViewController: UITableViewController {

    var allQandAs = [CKRecord]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllQueries()
    }
    
    private let database = CKContainer.defaultContainer().publicCloudDatabase
    
    private func fetchAllQueries() {
        let predicate = NSPredicate(format: "TRUEPREDICATE")
        let query = CKQuery(recordType: Cloud.Entity.QandA, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: Cloud.Attribute.Question, ascending: true)]
        database.performQuery(query, inZoneWithID: nil) { (records, error) in
            if records != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    self.allQandAs = records!
                })
            }
        }
    }
    
    //Data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allQandAs.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("QandA Cell", forIndexPath: indexPath)
        cell.textLabel?.text = allQandAs[indexPath.row][Cloud.Attribute.Question] as? String
        return cell
    }
    
    //Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show QandA" {
            if let ckQandATVC = segue.destinationViewController as? CouldQandAViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPathForCell(cell) {
                    ckQandATVC.ckQandARecord = allQandAs[indexPath.row]
                } else {
                    ckQandATVC.ckQandARecord = CKRecord(recordType: Cloud.Entity.QandA)
                }
            }
        }
    }

}
