//
//  BaseStackViewController.swift
//  GZStackView
//
//  Created by GenoZhou on 2017-03-14.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import UIKit

open class BaseStackViewController: UIViewController, StackViewContainer {
    
    // MARK: - Properties
    
    public var autoScrollView: AutoScrollView = AutoScrollView()
    public var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.spacing = 0
        return view
    }()
    public var stackViewItems: [StackViewItem] = []
    
    // set by default
    //    public var backgroundColor: UIColor = .white
    //    public var separatorClass: StackViewItemSeparator.Type = BaseSeparatorView.self
    //    var viewController: UIViewController { return self }
    
    // MARK: - Lifecycle
    
    open override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = false
        layoutStackViewContainerIfNeeded()
    }
    
}
