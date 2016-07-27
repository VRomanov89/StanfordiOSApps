//
//  NamedBezierPathView.swift
//  DropItApp
//
//  Created by Volodymyr Romanov on 7/27/16.
//  Copyright © 2016 Volodymyr Romanov. All rights reserved.
//

import UIKit

class NamedBezierPathView: UIView {
    public var bezierPaths: Dictionary = [String: UIBezierPath]() {
        didSet {
            setNeedsDisplay()
        }
    }
    override func drawRect(rect: CGRect) {
        for(_,path) in bezierPaths {
            path.stroke()
        }
    }
}
