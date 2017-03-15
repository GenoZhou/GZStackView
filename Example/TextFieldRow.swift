//
//  TextFieldRow.swift
//  StackViewController
//
//  Created by GenoZhou on 2017-02-26.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import UIKit

class TextFieldRow: UIView {
    
    let textField = UITextField()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 54)
    }
    
    convenience init(placeholder: String) {
        self.init()
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 16).isActive = true
        textField.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -16).isActive = true
        textField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        textField.placeholder = placeholder
    }
    
}
