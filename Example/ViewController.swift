//
//  ViewController.swift
//  Example
//
//  Created by GenoZhou on 2017-02-26.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import UIKit
import StackViewController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let switchA = SwitchRow(title: "SwitchA")
        let switchB = SwitchRow(title: "SwitchB")
        let switchC = SwitchRow(title: "SwitchC")
        let switchD = SwitchRow(title: "SwitchD")
        let switchE = SwitchRow(title: "SwitchE")
        let textFieldA = TextFieldRow(placeholder: "A", keyboardType: .default)
        let textFieldB = TextFieldRow(placeholder: "B", keyboardType: .default)
        let textFieldC = TextFieldRow(placeholder: "C", keyboardType: .default)
        let textFieldD = TextFieldRow(placeholder: "D", keyboardType: .default)
        let textFieldE = TextFieldRow(placeholder: "E", keyboardType: .default)
        let textFieldF = TextFieldRow(placeholder: "F", keyboardType: .default)
        let textFieldG = TextFieldRow(placeholder: "G", keyboardType: .default)
        let textFieldH = TextFieldRow(placeholder: "H", keyboardType: .default)
        let array = [switchA, switchB, switchC, switchD, switchE, textFieldA, textFieldB, textFieldC, textFieldD, textFieldE, textFieldF, textFieldG, textFieldH]
        addItems(array)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

