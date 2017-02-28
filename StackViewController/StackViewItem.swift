//
//  StackViewItem.swift
//  StackViewController
//
//  Created by GenoZhou on 2017-02-26.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import UIKit

public protocol StackViewItem: AnyObject {
    var viewForStack: UIView { get }
    var controllerForStack: UIViewController? { get }
}

public extension StackViewItem {
    public func registerSubviewRespondersTo(_ observable: ResponderObservable) {
        viewForStack.subviews.forEach {
            if $0.canBecomeFirstResponder {
                observable.registerResponder($0, withRelativeView: self.viewForStack)
            }
        }
    }
    public func unregisterSubviewRespondersFrom(_ observable: ResponderObservable) {
        viewForStack.subviews.forEach {
            if $0.canBecomeFirstResponder { observable.unregisterResponder($0) }
        }
    }
}

extension UIView: StackViewItem {
    public var viewForStack: UIView { return self }
    public var controllerForStack: UIViewController? { return nil }
}

extension UIViewController: StackViewItem {
    public var viewForStack: UIView { return self.view }
    public var controllerForStack: UIViewController? { return self }
}
