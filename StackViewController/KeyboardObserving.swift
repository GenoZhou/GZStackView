//
//  KeyboardObserving.swift
//  StackViewController
//
//  Created by GenoZhou on 2017-02-28.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import Foundation

@objc protocol KeyboardObserving {
    func keyboardWillShow(_ sender: Notification)
    func keyboardWillHide(_ sender: Notification)
}

extension KeyboardObserving {
    func startObservingKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func stopObservingKeyboard() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
}
