//
//  Reusable.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/27/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import Foundation
import MapKit
import UIKit

/**
 🌮 Reusable
    Created by Will Asrari
 Simple protocol to facilitate a standard pattern for adopting
 reuse identifiers for `UITableView` and `UICollectionView` cell
 subclasses.  This is especially helpful when working with various
 prototype cells.
 */

public protocol Reusable {
    static func defaultReuseIdentifier() -> String

    func prepareForReuse()
}

extension UIView: Reusable {
    public class func defaultReuseIdentifier() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    open func prepareForReuse() {}
}
