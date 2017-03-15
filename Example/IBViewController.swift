//
//  IBViewController.swift
//  GZStackView
//
//  Created by GenoZhou on 2017-03-14.
//  Copyright © 2017 GenoZhou. All rights reserved.
//

import UIKit
import GZStackView

class IBViewController: UIViewController, StackViewContainer {
    
    @IBOutlet weak var _autoScrollView: AutoScrollView!
    @IBOutlet weak var _stackView: UIStackView!
    @IBOutlet var items: [UIView]!
    
    var autoScrollView: AutoScrollView { return _autoScrollView }
    var stackView: UIStackView { return _stackView }
    var stackViewItems: [StackViewItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addItems(items, hideSeparator: true)
    }

    @IBAction func goNext(_ sender: Any) {
        let simpleVC = SimpleViewController()
        navigationController?.pushViewController(simpleVC, animated: true)
    }
}
