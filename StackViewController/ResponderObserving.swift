//
//  ResponderObserving.swift
//  StackViewController
//
//  Created by GenoZhou on 2017-02-28.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import Foundation

protocol ResponderObserving: class {
    var responderObservingPool: [UIResponder: AnyObject?] { get set }
}

extension ResponderObserving {
    var firstResponder: UIResponder? {
        return responderObservingPool.filter { $0.key.isFirstResponder }.first?.key
    }
    var firstResponderFrame: CGRect? {
        let pair = responderObservingPool.filter { $0.key.isFirstResponder }.first
        return (pair?.value as? UIView)?.frame ?? (pair?.key as? UIView)?.frame
    }
    func registerResponder(_ responder: UIResponder, withAssociateObject associatedObject: AnyObject? = nil) {
        responderObservingPool[responder] = associatedObject
    }
    func unregisterResponder(_ responder: UIResponder) {
        responderObservingPool[responder] = nil
    }
    func registerRespondersFromView(_ view: UIView) {
        let possibilities = view.subviews.filter { $0.canBecomeFirstResponder }.flatMap { [$0:view] }
        possibilities.forEach { registerResponder($0.key, withAssociateObject: $0.value) }
    }
    func unregisterRespondersFromView(_ view: UIView) {
        let possibilities = view.subviews.filter { $0.canBecomeFirstResponder }
        possibilities.forEach { unregisterResponder($0) }
    }
}
