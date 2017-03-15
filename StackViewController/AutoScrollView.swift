//
//  AutoScrollView.swift
//  StackViewController
//
//  Created by GenoZhou on 2017-02-26.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import UIKit

@IBDesignable
open class AutoScrollView: UIScrollView, ResponderObserving, KeyboardObserving {
    
    // MARK: - Properties
    
    public var isAutoScrollEnabled: Bool = true {
        didSet {
            isAutoScrollEnabled ? startObservingKeyboard() : stopObservingKeyboard()
        }
    }
    
    public var responderObservingPool: [UIResponder : AnyObject?] = [:]
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        startObservingKeyboard()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        startObservingKeyboard()
    }
    
    deinit {
        stopObservingKeyboard()
    }
    
    // MARK: - Public Methods
    
    public func addManagedSubview(_ view: UIView) {
        registerRespondersFromView(view)
        addSubview(view)
    }
    
    public func removeManagedSubview(_ view: UIView) {
        unregisterRespondersFromView(view)
        view.removeFromSuperview()
    }
    
    // MARK: - KeyboardObserving
    
    public func keyboardWillShow(_ sender: Notification) {
        guard
            let keyboardHeight = (sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height,
            let duration = sender.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curveValue = sender.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Int,
            let curve = UIViewAnimationCurve.init(rawValue: curveValue),
            let frame = firstResponderFrame
            else { return }
        
        var animationOption: UIViewAnimationOptions
        switch curve {
        case .easeIn:
            animationOption = UIViewAnimationOptions.curveEaseIn
        case .easeInOut:
            animationOption = UIViewAnimationOptions.curveEaseInOut
        case .easeOut:
            animationOption = UIViewAnimationOptions.curveEaseOut
        case .linear:
            animationOption = UIViewAnimationOptions.curveLinear
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: animationOption, animations: {
            self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            self.scrollRectToVisible(frame, animated: false)
        }, completion: nil)
    }
    
    public func keyboardWillHide(_ sender: Notification) {
        contentInset = UIEdgeInsets.zero
    }
    
    public func keyboardDidShow(_ sender: Notification) { }
    
    public func keyboardDidHide(_ sender: Notification) { }
    
}
