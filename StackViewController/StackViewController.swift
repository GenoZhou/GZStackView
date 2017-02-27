//
//  StackViewController.swift
//  StackViewController
//
//  Created by GenoZhou on 2017-02-26.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import UIKit

open class StackViewController: UIViewController {
    
    // MARK: - Public properties
    
    open var configuration: ((UIStackView) -> Void)? {
        didSet {
            if let configuration = configuration {
                configuration(stackView)
            }
            guard stackViewAxisConstraint != nil else { return }
            setupstackViewAxisConstraint()
        }
    }
    open var seperatorClass: StackViewSeperatorType.Type?
    
    // MARK: - Private properties
    
    private var scrollView = UIScrollView()
    private var stackView = UIStackView()
    private var stackViewAxisConstraint: NSLayoutConstraint?
    private var items: [StackViewItem] = []
    
    // MARK: - Lifecycle
    
    open override func loadView() {
        super.loadView()
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        setupstackViewAxisConstraint()
    }
    
    // MARK: - Public Methods
    
    open func addItem(_ item: StackViewItem, hideSeperator: Bool = false) {
        insertItem(item, atIndex: items.count, hideSeperator: hideSeperator)
    }
    
    open func addItems(_ items: [StackViewItem], hideSeperator: Bool = false) {
        items.forEach { addItem($0, hideSeperator: hideSeperator) }
    }
    
    open func insertItem(_ item: StackViewItem, atIndex index: Int, hideSeperator: Bool = false) {
        guard index <= items.count && index >= 0 else { fatalError("index out of range") }
        items.insert(item, at: index)
        stackView.insertArrangedSubview(item.viewForStack, at: index)
        if let controller = item.controllerForStack {
            addChildViewController(controller)
            controller.didMove(toParentViewController: self)
        }
        if !hideSeperator {
            let axis: UILayoutConstraintAxis = (stackView.axis == UILayoutConstraintAxis.horizontal) ? .vertical : .horizontal
            seperatorClass?.attachTo(stackViewItem: item, withAxis: axis)
        }
    }
    
    open func removeItem(_ item: StackViewItem) {
        guard let index = items.index(where: { $0 === item }) else { return }
        removeItem(atIndex: index)
    }
    
    open func removeItems(_ items: [StackViewItem]) {
        items.forEach {
            item in
            guard let index = items.index(where: { $0 === item }) else { return }
            removeItem(atIndex: index)
        }
    }
    
    open func removeItem( atIndex index: Int) {
        guard index <= items.count && index >= 0 else { fatalError("index out of range") }
        let item = items[index]
        items.remove(at: index)
        stackView.removeArrangedSubview(item.viewForStack)
        if let controller = item.controllerForStack {
            controller.willMove(toParentViewController: nil)
            controller.removeFromParentViewController()
        }
    }
    
    // MARK: - Private Methods
    
    private func setupstackViewAxisConstraint() {
        stackViewAxisConstraint?.isActive = false
        switch stackView.axis {
        case .horizontal:
            stackViewAxisConstraint = stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        case .vertical:
            stackViewAxisConstraint = stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        }
        stackViewAxisConstraint?.isActive = true
    }

}
