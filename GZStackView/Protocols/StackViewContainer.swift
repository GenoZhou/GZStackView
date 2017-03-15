//
//  StackViewContainer.swift
//  StackViewController
//
//  Created by Mobile on 2017-03-01.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import Foundation

public protocol StackViewContainer: class {
    var stackViewItems: [StackViewItem] { get set }
    var autoScrollView: AutoScrollView { get }
    var stackView: UIStackView { get }
    var backgroundColor: UIColor { get }
    var separatorClass: StackViewItemSeparator.Type { get }
    var container: UIViewController { get }
}

extension StackViewContainer {
    public var backgroundColor: UIColor { return .white }
    public var separatorClass: StackViewItemSeparator.Type { return BaseSeparatorView.self }
}

extension StackViewContainer {
    public func layoutStackViewContainerIfNeeded() {
        if !container.view.subviews.contains(autoScrollView) {
            container.view.addSubview(autoScrollView)
            autoScrollView.backgroundColor = backgroundColor
            autoScrollView.translatesAutoresizingMaskIntoConstraints = false
            autoScrollView.topAnchor.constraint(equalTo: container.topLayoutGuide.bottomAnchor).isActive = true
            autoScrollView.bottomAnchor.constraint(equalTo: container.bottomLayoutGuide.topAnchor).isActive = true
            autoScrollView.leadingAnchor.constraint(equalTo: container.view.leadingAnchor).isActive = true
            autoScrollView.trailingAnchor.constraint(equalTo: container.view.trailingAnchor).isActive = true
        }
        if !autoScrollView.subviews.contains(stackView) {
            autoScrollView.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.topAnchor.constraint(equalTo: autoScrollView.topAnchor).isActive = true
            stackView.bottomAnchor.constraint(equalTo: autoScrollView.bottomAnchor).isActive = true
            stackView.leadingAnchor.constraint(equalTo: autoScrollView.leadingAnchor).isActive = true
            stackView.trailingAnchor.constraint(equalTo: autoScrollView.trailingAnchor).isActive = true
            switch stackView.axis {
            case .horizontal:
                stackView.heightAnchor.constraint(equalTo: autoScrollView.heightAnchor).isActive = true
                stackView.widthAnchor.constraint(equalTo: autoScrollView.widthAnchor).isActive = false
            case .vertical:
                stackView.heightAnchor.constraint(equalTo: autoScrollView.heightAnchor).isActive = false
                stackView.widthAnchor.constraint(equalTo: autoScrollView.widthAnchor).isActive = true
            }
        }
    }
    
    public func addItem(_ item: StackViewItem, hideSeparator: Bool = false) {
        insertItem(item, atIndex: stackViewItems.count, hideSeparator: hideSeparator)
    }
    
    public func addItems(_ items: [StackViewItem], hideSeparator: Bool = false) {
        items.forEach { addItem($0, hideSeparator: hideSeparator) }
    }
    
    public func insertItem(_ item: StackViewItem, atIndex index: Int, hideSeparator: Bool = false) {
        // precondition
        guard index <= stackViewItems.count && index >= 0 else { fatalError("index out of range") }
        // update stack view items
        stackViewItems.insert(item, at: index)
        // update stack view
        stackView.insertArrangedSubview(item.viewForStack, at: index)
        // update auto scroll view
        autoScrollView.registerRespondersFromView(item.viewForStack)
        // add controller if exist
        if let controller = item.controllerForStack {
            container.addChildViewController(controller)
            controller.didMove(toParentViewController: container)
        }
        // add separator if needed
        if !hideSeparator {
            let axis: UILayoutConstraintAxis = (stackView.axis == UILayoutConstraintAxis.horizontal) ? .vertical : .horizontal
            separatorClass.attachTo(stackViewItem: item, withAxis: axis)
        }
    }
    
    public func insertItems(_ items: [StackViewItem], fromIndex index: Int, hideSeparator: Bool = false) {
        // precondition
        guard index <= items.count && index >= 0 else { fatalError("index out of range") }
        var index = index
        items.forEach {
            insertItem($0, atIndex: index, hideSeparator: hideSeparator)
            index += 1
        }
    }
    
    public func removeItem(_ item: StackViewItem) {
        guard let index = stackViewItems.index(where: { $0 === item }) else { return }
        removeItem(atIndex: index)
    }
    
    public func removeItems(_ items: [StackViewItem]) {
        items.forEach {
            item in
            guard let index = self.stackViewItems.index(where: { $0 === item }) else { return }
            removeItem(atIndex: index)
        }
    }
    
    public func removeItem(atIndex index: Int) {
        // precondition
        guard index <= stackViewItems.count && index >= 0 else { fatalError("index out of range") }
        // update stack view items
        let item = stackViewItems[index]
        stackViewItems.remove(at: index)
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
}

extension StackViewContainer where Self: UIViewController {
    public var container: UIViewController { return self }
}
