//
//  StackViewContainer.swift
//  StackViewController
//
//  Created by Mobile on 2017-03-01.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import Foundation

public protocol StackViewContainer: class {
    var autoScrollView: AutoScrollView { get }
    var stackView: UIStackView { get }
    var items: [StackViewItem] { get set }
    var backgroundColor: UIColor { get }
    var separatorClass: StackViewItemSeparator.Type { get }
}

extension StackViewContainer where Self: UIViewController {
    
    public func layoutAutoScrollView() {
        if !view.subviews.contains(autoScrollView) {
            view.addSubview(autoScrollView)
        }
        autoScrollView.translatesAutoresizingMaskIntoConstraints = false
        autoScrollView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        autoScrollView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        autoScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        autoScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    public func layoutStackView() {
        if !autoScrollView.subviews.contains(stackView) {
            autoScrollView.addSubview(stackView)
        }
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
            separatorClass.attachTo(stackViewItem: item, withAxis: axis)
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
    
}
