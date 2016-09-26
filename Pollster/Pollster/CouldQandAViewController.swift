//
//  CouldQandAViewController.swift
//  Pollster
//
//  Created by Volodymyr Romanov on 7/28/16.
//  Copyright © 2016 Volodymyr Romanov. All rights reserved.
//

import UIKit
import CloudKit

class CouldQandAViewController: QandATableViewController {
    var ckQandARecord :CKRecord {
        get {
            if _ckQandARecord == nil {
                _ckQandARecord = CKRecord(recordType: Cloud.Entity.QandA)
            }
            return _ckQandARecord!
        }
        set {
            _ckQandARecord = newValue
        }
    }
    private var _ckQandARecord: CKRecord? {
        didSet {
            let question = ckQandARecord[Cloud.Attribute.Question] as? String ?? ""
            let answers = ckQandARecord[Cloud.Attribute.Answers] as? [String] ?? []
            qanda = QandA(question: question, answers: answers)
            asking = ckQandARecord.wasCreatedByThisUser
        }
    }
    
    override func textViewDidEndEditing(textView: UITextView) {
        super.textViewDidEndEditing(textView)
        iCloudUpdate()
    }
    
    private let database = CKContainer.defaultContainer().publicCloudDatabase
    
    @objc private func iCloudUpdate() {
        if !qanda.question.isEmpty && !qanda.answers.isEmpty {
            ckQandARecord[Cloud.Attribute.Question] = qanda.question
            ckQandARecord[Cloud.Attribute.Answers] = qanda.answers
            iCloudSaveRecord(ckQandARecord)
        }
    }
    
    private func iCloudSaveRecord(recordToSave: CKRecord) {
        
        database.saveRecord(recordToSave) { (savedRecord, error) in
            
            if error?.code == CKErrorCode.ServerRecordChanged.rawValue {
                //ignore
                //print("test1")
            } else if error != nil {
                self.retryAfterError(error, withSelector: #selector(self.iCloudUpdate))
                print("\(error?.userInfo.description)")
            }
        }
    }
    
    private func retryAfterError(error: NSError?, withSelector selector: Selector) {
        if let retryInterval = error?.userInfo[CKErrorRetryAfterKey] as? NSTimeInterval {
            dispatch_async(dispatch_get_main_queue()) {
                NSTimer.scheduledTimerWithTimeInterval(
                retryInterval,
                target: self,
                selector: selector,
                userInfo: nil,
                repeats: false
                )
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ckQandARecord = CKRecord(recordType: Cloud.Entity.QandA)
    }
}
