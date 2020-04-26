//
//  DataBindable.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/11/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import Foundation
import UIKit

/*
 DataBindable
   Protocol allows for a simple API for abstracting out a common pattern that
   we use almost every day.  Many of our `UIKit` subclasses provide facilities
   for passing in a model object (i.e. `SBXStoreOld`) to populate a user-interface.
   Standardizing this pattern opens up the potential of other opportunities to
   abstract similar patterns in other areas of an application.
   A view that is static today can be extended by conforming to `DataBindable`.
 */

public protocol DataBindable {
    associatedtype DataType
    func bind(data: DataType?)
}

/*
 Why do we have it with a type void? When that’ll never do anything?
 It’s to support type constraints in various facilities that reduce boilerplate in setting up
 UITableViewDataSource and UICollectionViewDataSource objects. Sometimes there are cells that don’t use
 associated models to display content. This default extension added so developers who want to leverage
 these facilities don’t have to implement a bind method. The protocol in question provides a consistent
 API for setting associated models in a UITableViewCell and/or UICollectionViewCell view.
 */
extension DataBindable where DataType == Void {
    public func bind(data: Void?) {}
}
