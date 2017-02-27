//
//  SwitchRow.swift
//  Example
//
//  Created by GenoZhou on 2017-02-26.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import UIKit

public class SwitchRow: UIView {
    
    let titleLabel = UILabel()
    let switchControl = UISwitch()
    
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 54)
    }
    
    public convenience init(title: String?) {
        self.init()
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(switchControl)
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -16).isActive = true
        switchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        titleLabel.text = title
        switchControl.isOn = false
    }
    
}
