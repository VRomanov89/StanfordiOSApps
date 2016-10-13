//
//  CassiniViewController.swift
//  Cassini 2.0
//
//  Created by Volodymyr Romanov on 9/27/16.
//  Copyright © 2016 Vladimir Romanov. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {
    private struct Storyboard {
        static let ShowImageSegue = "ShowImage"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.ShowImageSegue {
            if let ivc = segue.destination.contentViewcontroller as? ImageViewController {
                let imageName = (sender as? UIButton)?.currentTitle
                ivc.imageURL = DemoURL.NASAImageNamed(imageName)
                ivc.title = imageName
            }
        }
    }
}

extension UIViewController {
    var contentViewcontroller: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
