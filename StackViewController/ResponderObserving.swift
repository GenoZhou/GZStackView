//
//  ResponderObserving.swift
//  StackViewController
//
//  Created by GenoZhou on 2017-02-28.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import Foundation

public protocol ResponderObserving: class {
    var responderObservingPool: [UIResponder: AnyObject?] { get set }
}

extension ResponderObserving {
    public var firstResponder: UIResponder? {
        return responderObservingPool.filter { $0.key.isFirstResponder }.first?.key
    }
    
    public var firstResponderFrame: CGRect? {
        let pair = responderObservingPool.filter { $0.key.isFirstResponder }.first
        return (pair?.value as? UIView)?.frame ?? (pair?.key as? UIView)?.frame
    }
    
    public func registerResponder(_ responder: UIResponder, withAssociateObject associatedObject: AnyObject? = nil) {
        responderObservingPool[responder] = associatedObject
    }
    
    public func unregisterResponder(_ responder: UIResponder) {
        responderObservingPool[responder] = nil
    }
    
    public func registerRespondersFromView(_ view: UIView) {
        let possibilities = view.subviews.filter { $0.canBecomeFirstResponder }.flatMap { [$0:view] }
        possibilities.forEach { registerResponder($0.key, withAssociateObject: $0.value) }
    }
    
    public func unregisterRespondersFromView(_ view: UIView) {
        let possibilities = view.subviews.filter { $0.canBecomeFirstResponder }
        possibilities.forEach { unregisterResponder($0) }
    }
}
