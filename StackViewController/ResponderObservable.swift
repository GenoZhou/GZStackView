//
//  ResponderObservable.swift
//  StackViewController
//
//  Created by GenoZhou on 2017-02-28.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import Foundation

public protocol ResponderObservable: class {
    var responderObservingPoolKey: UnsafeMutablePointer<CInt> { get set }
}

var key: Void?

public extension ResponderObservable {
    public var firstResponder: UIResponder? {
        for item in pool {
            if item.key.isFirstResponder { return item.key }
        }
        return nil
    }
    public var firstResponderRelativeFrame: CGRect? {
        for item in pool {
            if item.key.isFirstResponder { return item.value?.frame }
        }
        return nil
    }
    
    public func registerResponder(_ responder: UIResponder, withRelativeView relativeView: UIView?) {
        pool[responder] = relativeView
    }
    public func unregisterResponder(_ responder: UIResponder) {
        pool[responder] = nil
    }
    
    private var pool: [UIResponder: UIView?] {
        get {
            return objc_getAssociatedObject(self, responderObservingPoolKey) as? [UIResponder: UIView?] ?? [:]
        }
        set {
            objc_setAssociatedObject(self, responderObservingPoolKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
