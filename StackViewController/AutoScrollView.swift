//
//  AutoScrollView.swift
//  StackViewController
//
//  Created by GenoZhou on 2017-02-26.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import UIKit

open class AutoScrollView: UIScrollView, ResponderObservable {
    
    // MARK: - Properties
    
    public var responderObservingPoolKey = UnsafeMutablePointer<CInt>.allocate(capacity: 1)
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        bindNotification()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        bindNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Private Methods
    
    private func bindNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardWillShow(_ sender: Notification) {
        guard
            let keyboardHeight = (sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height,
            let duration = sender.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curveValue = sender.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Int,
            let curve = UIViewAnimationCurve.init(rawValue: curveValue),
            let frame = firstResponderRelativeFrame
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
    
    @objc private func keyboardWillHide(_ sender: Notification) {
        contentInset = UIEdgeInsets.zero
    }
}
