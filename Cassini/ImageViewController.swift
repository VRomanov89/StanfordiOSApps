//
//  ImageViewController.swift
//  Cassini
//
//  Created by Volodymyr Romanov on 7/23/16.
//  Copyright © 2016 Volodymyr Romanov. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController
{
    var imageURL: NSURL? {
        didSet {
            image = nil
            fetchImage()
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            if let imageData = NSData(contentsOfURL: url) {
                image = UIImage(data: imageData)
            }
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    private var imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
        imageURL = NSURL(string: DemoURL.Stanford)
    }

}
