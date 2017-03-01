//
//  StackViewSeperatorType.swift
//  StackViewController
//
//  Created by GenoZhou on 2017-02-26.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import Foundation

extension BaseSeperatorView: StackViewItemSeperator {
    public static func attachTo(stackViewItem: StackViewItem, withAxis axis: UILayoutConstraintAxis) {
        let view = stackViewItem.viewForStack
        let seperator = BaseSeperatorView(axis: axis)
        view.addSubview(seperator)
        seperator.translatesAutoresizingMaskIntoConstraints = false
        switch axis {
        case .horizontal:
            seperator.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            seperator.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            seperator.bottomAnchor.constraint(equalTo: view.viewForStack.bottomAnchor, constant: -1).isActive = true
        case .vertical:
            seperator.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            seperator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1).isActive = true
            seperator.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }
}

open class BaseSeperatorView: UIView {
    
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
