//
//  ViewController.swift
//  Example
//
//  Created by GenoZhou on 2017-02-26.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import UIKit
import StackViewController

class ViewController: StackViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration = {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .equalSpacing
            $0.spacing = 0
        }
        seperatorClass = StackViewSeperatorView.self
        
        let switchA = SwitchRow(title: "SwitchA")
        let switchB = SwitchRow(title: "SwitchB")
        let switchC = SwitchRow(title: "SwitchC")
        let switchD = SwitchRow(title: "SwitchD")
        let switchE = SwitchRow(title: "SwitchE")
        let array = [switchA, switchB, switchC, switchD, switchE]
        addItems(array)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

