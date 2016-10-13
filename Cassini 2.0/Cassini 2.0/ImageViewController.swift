//
//  ImageViewController.swift
//  Cassini 2.0
//
//  Created by Volodymyr Romanov on 9/25/16.
//  Copyright © 2016 Vladimir Romanov. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView?.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    fileprivate func fetchImage() {
        if let url = imageURL {
            DispatchQueue.global().async {
                let contentsOfURL = NSData(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = contentsOfURL {
                        self.image = UIImage(data: imageData as Data)
                    }
                }
            }
        }
    }
    
    fileprivate var imageView = UIImageView() // Image View of 0,0,0,0
    
    fileprivate var image: UIImage? {
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
        //imageURL = URL(string: DemoURL.NASA["Cassini"]!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
}
