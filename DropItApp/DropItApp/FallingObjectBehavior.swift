//
//  FallingObjectBehavior.swift
//  DropItApp
//
//  Created by Volodymyr Romanov on 7/27/16.
//  Copyright © 2016 Volodymyr Romanov. All rights reserved.
//

import UIKit

class FallingObjectBehavior: UIDynamicBehavior {
    private let gravity = UIGravityBehavior()
    private let collider: UICollisionBehavior = {
        let collider = UICollisionBehavior()
        collider.translatesReferenceBoundsIntoBoundary = true
        return collider
    }()
    private let itemBehavior: UIDynamicItemBehavior = {
        let dib = UIDynamicItemBehavior()
        dib.allowsRotation = true
        dib.elasticity = 0.75
        return dib
    }()
    func addBarrier(path: UIBezierPath, named name: String) {
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(itemBehavior)
    }
    func addItem(item: UIDynamicItem) {
        gravity.addItem(item)
        collider.addItem(item)
        itemBehavior.addItem(item)
    }
    func removeItem (item: UIDynamicItem) {
        gravity.removeItem(item)
        collider.removeItem(item)
        itemBehavior.removeItem(item)
    }
}
