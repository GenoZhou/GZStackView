//
//  SimpleViewController.swift
//  Example
//
//  Created by GenoZhou on 2017-03-14.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import UIKit
import GZStackView

class SimpleViewController: BaseStackViewController {

    // MARK: - Properties
    
    let text1 = TextFieldRow(placeholder: "Text1")
    let text2 = TextFieldRow(placeholder: "Text2")
    let text3 = TextFieldRow(placeholder: "Text3")
    let text4 = TextFieldRow(placeholder: "Text4")
    let text5 = TextFieldRow(placeholder: "Text5")
    let text6 = TextFieldRow(placeholder: "Text6")
    let text7 = TextFieldRow(placeholder: "Text7")
    let text8 = TextFieldRow(placeholder: "Text8")
    
    // MARK: - Lifecycle
    
    open override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let views = [text1, text2, text3, text4, text5, text6, text7, text8]
        addItems(views)
    }

}

