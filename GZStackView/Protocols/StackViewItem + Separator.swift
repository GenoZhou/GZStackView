//
//  StackViewItem + Separator.swift
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

extension UIView: StackViewItem {
    public var viewForStack: UIView { return self }
    public var controllerForStack: UIViewController? { return nil }
}

extension UIViewController: StackViewItem {
    public var viewForStack: UIView { return self.view }
    public var controllerForStack: UIViewController? { return self }
}

public protocol StackViewItemSeparator {
    static func attachTo(stackViewItem: StackViewItem, withAxis axis: UILayoutConstraintAxis)
}
