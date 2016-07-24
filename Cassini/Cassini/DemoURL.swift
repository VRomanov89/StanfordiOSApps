//
//  File.swift
//  Cassini
//
//  Created by Volodymyr Romanov on 7/23/16.
//  Copyright © 2016 Volodymyr Romanov. All rights reserved.
//

import Foundation

struct DemoURL {
    static let Stanford = "http://comm.stanford.edu/wp-content/uploads/2013/01/stanford-campus.png"
    
    static let NASA = [
        "Cassini" : "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg"
    ]
    
    static func NASAImageNamed(imageName: String?) -> NSURL? {
        if let urlstring = NASA[imageName ?? ""] {
            return NSURL(string: urlstring)
        }else {
            return nil
        }
    }
}