//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Volodymyr Romanov on 7/24/16.
//  Copyright © 2016 Volodymyr Romanov. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {
    private struct Storyboard {
        static let ShowImageSegue = "Show Image"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.ShowImageSegue {
            if let ivc = segue.destinationViewController.contentViewController as? ImageViewController {
                let imageName = (sender as? UIButton)?.currentTitle
                ivc.imageURL = DemoURL.NASAImageNamed(imageName)
                ivc.title = imageName
            }
        }
    }
}

extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}