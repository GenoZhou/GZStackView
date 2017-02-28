//
//  StackViewSeperatorType.swift
//  StackViewController
//
//  Created by GenoZhou on 2017-02-26.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import Foundation

public protocol StackViewSeperatorType {
    static func attachTo(stackViewItem: StackViewItem, withAxis axis: UILayoutConstraintAxis)
}

open class StackViewSeperatorView: UIView, StackViewSeperatorType {
    public var thickness: CGFloat
    public var axis: UILayoutConstraintAxis
    
    open override var intrinsicContentSize: CGSize {
        switch axis {
        case .horizontal:
            return CGSize(width: UIViewNoIntrinsicMetric, height: thickness)
        case .vertical:
            return CGSize(width: thickness, height: UIViewNoIntrinsicMetric)
        }
    }
    
    public init(thickness: CGFloat = 1.0, color: UIColor = .groupTableViewBackground, axis: UILayoutConstraintAxis) {
        self.thickness = thickness
        self.axis = axis
        super.init(frame: .zero)
        backgroundColor = color
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public static func attachTo(stackViewItem: StackViewItem, withAxis axis: UILayoutConstraintAxis) {
        let view = stackViewItem.viewForStack
        let seperator = StackViewSeperatorView(axis: axis)
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
