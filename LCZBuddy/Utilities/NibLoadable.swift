//
//  NibLoadable.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/27/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import Foundation
import UIKit

/**
 🌮 NibLoadable
 
 Formalizing the pattern that we have been using to load views
 from nib files.
 
 - Will Asrari
 */
public protocol NibLoadable {
    static var nibName: String { get }
    static var nib: UINib { get }
    
    func loadViewFromNib() -> UIView
    func viewFromNib() -> UIView
}

public extension NibLoadable {
    static func load() -> Self {
        let nib = Self.nib
        let view = nib.instantiate(withOwner: nil, options: [:])[0]
        guard let castedView = view as? Self else { fatalError() }
        return castedView
    }
}

public typealias NibLoadableView = UIView & NibLoadable

/**
 🌮 SBXUINibLoadable (Default Implementation)
 
 Default implementation via protocol extension. A view with a corresponding nib
 (using the same name as the class) only needs to create an empty extension
 conforming to this protocol. This is sometimes to referred to as using a Swift
 "trait" or "mixin" and has roots in functional programming languages.
 */
public extension NibLoadable where Self: UIView {
    static var nibName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: Self.self))
    }
    
    @discardableResult
    func loadViewFromNib() -> UIView {
        let view = viewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
        return view
    }
    
    func viewFromNib() -> UIView {
        guard let view = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError() }
        return view
    }
}

extension UITableViewCell: NibLoadable {
    public class var nibName: String {
        return defaultReuseIdentifier()
    }
    
    public class var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: self.self))
    }
    
    public func loadViewFromNib<T: UIView>(_: T.Type) where T: NibLoadable {
        let view = viewFromNib(T.self)
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
    }
    
    public func viewFromNib<T: UIView>(_: T.Type) -> T where T: NibLoadable {
        guard let view = T.nib.instantiate(withOwner: self, options: nil).first(where: { $0 is UIView }) as? T else { fatalError() }
        return view
    }
}

extension UICollectionViewCell: NibLoadable {
    public func loadViewFromNib<T: UIView>(_: T.Type) where T: NibLoadable {
        let view = viewFromNib(T.self)
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
    }
    
    public func viewFromNib<T: UIView>(_: T.Type) -> T where T: NibLoadable {
        guard let view = T.nib.instantiate(withOwner: self, options: nil).first(where: { $0 is UIView }) as? T else { fatalError() }
        return view
    }
}

public extension NibLoadable where Self: UICollectionReusableView {
    static var nibName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: Self.self))
    }
    
    @discardableResult
    func loadViewFromNib() -> UIView {
        let view = viewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
        return view
    }
    
    func viewFromNib() -> UIView {
        guard let view = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError() }
        return view
    }
}

extension UITableViewHeaderFooterView: NibLoadable {}
