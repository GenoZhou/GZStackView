//
//  StackViewController.swift
//  StackViewController
//
//  Created by GenoZhou on 2017-02-26.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import UIKit

open class StackViewController: UIViewController {
    
    // MARK: - Properties
    
    public var configuration: ((UIStackView) -> Void)? {
        didSet {
            if let configuration = configuration {
                configuration(stackView)
            }
            guard stackViewAxisConstraint != nil else { return }
            updateStackViewAxisConstraint()
        }
    }
    public var backgroundColor: UIColor = .white {
        didSet {
            autoScrollView.backgroundColor = backgroundColor
        }
    }
    public var seperatorClass: StackViewItemSeperator.Type? = BaseSeperatorView.self
    
    var autoScrollView: AutoScrollView = AutoScrollView()
    var stackView: UIStackView = UIStackView()
    var stackViewAxisConstraint: NSLayoutConstraint?
    var items: [StackViewItem] = []
    
    // MARK: - Lifecycle
    
    open override func loadView() {
        super.loadView()
        view.addSubview(autoScrollView)
        autoScrollView.translatesAutoresizingMaskIntoConstraints = false
        autoScrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        autoScrollView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        autoScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        autoScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        autoScrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: autoScrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: autoScrollView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: autoScrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: autoScrollView.trailingAnchor).isActive = true
        updateStackViewAxisConstraint()
    }

    // MARK: - Public Methods
    
    public func addItem(_ item: StackViewItem, hideSeperator: Bool = false) {
        insertItem(item, atIndex: items.count, hideSeperator: hideSeperator)
    }
    
    public func addItems(_ items: [StackViewItem], hideSeperator: Bool = false) {
        items.forEach { addItem($0, hideSeperator: hideSeperator) }
    }
    
    public func insertItem(_ item: StackViewItem, atIndex index: Int, hideSeperator: Bool = false) {
        // precondition
        guard index <= items.count && index >= 0 else { fatalError("index out of range") }
        // update stack view items
        items.insert(item, at: index)
        // update stack view
        stackView.insertArrangedSubview(item.viewForStack, at: index)
        // update auto scroll view
        autoScrollView.registerRespondersFromView(item.viewForStack)
        // add controller if exist
        if let controller = item.controllerForStack {
            addChildViewController(controller)
            controller.didMove(toParentViewController: self)
        }
        // add seperator if needed
        if !hideSeperator {
            let axis: UILayoutConstraintAxis = (stackView.axis == UILayoutConstraintAxis.horizontal) ? .vertical : .horizontal
            seperatorClass?.attachTo(stackViewItem: item, withAxis: axis)
        }
    }
    
    public func insertItems(_ items: [StackViewItem], fromIndex index: Int, hideSeperator: Bool = false) {
        // precondition
        guard index <= items.count && index >= 0 else { fatalError("index out of range") }
        var index = index
        items.forEach {
            insertItem($0, atIndex: index, hideSeperator: hideSeperator)
            index += 1
        }
    }
    
    public func removeItem(_ item: StackViewItem) {
        guard let index = items.index(where: { $0 === item }) else { return }
        removeItem(atIndex: index)
    }
    
    public func removeItems(_ items: [StackViewItem]) {
        items.forEach {
            item in
            guard let index = self.items.index(where: { $0 === item }) else { return }
            removeItem(atIndex: index)
        }
    }
    
    public func removeItem( atIndex index: Int) {
        // precondition
        guard index <= items.count && index >= 0 else { fatalError("index out of range") }
        // update stack view items
        let item = items[index]
        items.remove(at: index)
        // update stack view
        stackView.removeArrangedSubview(item.viewForStack)
        // update auto scroll view
        autoScrollView.unregisterRespondersFromView(item.viewForStack)
        // remove view from hierarchy
        item.viewForStack.removeFromSuperview()
        // remove controller if exist
        if let controller = item.controllerForStack {
            controller.willMove(toParentViewController: nil)
            controller.removeFromParentViewController()
        }
    }
    
    // MARK: - Private Methods
    
    private func updateStackViewAxisConstraint() {
        stackViewAxisConstraint?.isActive = false
        switch stackView.axis {
        case .horizontal:
            stackViewAxisConstraint = stackView.heightAnchor.constraint(equalTo: autoScrollView.heightAnchor)
        case .vertical:
            stackViewAxisConstraint = stackView.widthAnchor.constraint(equalTo: autoScrollView.widthAnchor)
        }
        stackViewAxisConstraint?.isActive = true
    }

}
