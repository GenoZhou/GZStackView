//
//  StackViewSeparatorType.swift
//  StackViewController
//
//  Created by GenoZhou on 2017-02-26.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import Foundation

open class BaseSeparatorView: UIView {
    
    // MARK: - Properties
    
    public var axis: UILayoutConstraintAxis = .horizontal
    open override var intrinsicContentSize: CGSize {
        switch axis {
        case .horizontal:
            return CGSize(width: UIViewNoIntrinsicMetric, height: 1)
        case .vertical:
            return CGSize(width: 1, height: UIViewNoIntrinsicMetric)
        }
    }
    
    // MARK: - Initialization
    
    convenience init(axis: UILayoutConstraintAxis) {
        self.init()
        self.axis = axis
        self.backgroundColor = .groupTableViewBackground
    }
    
}

extension BaseSeparatorView: StackViewItemSeparator {
    public static func attachTo(stackViewItem: StackViewItem, withAxis axis: UILayoutConstraintAxis) {
        let view = stackViewItem.viewForStack
        let separator = BaseSeparatorView(axis: axis)
        view.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        switch axis {
        case .horizontal:
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            separator.bottomAnchor.constraint(equalTo: view.viewForStack.bottomAnchor, constant: -1).isActive = true
        case .vertical:
            separator.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            separator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1).isActive = true
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }
}
