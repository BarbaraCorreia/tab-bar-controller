//
//  ViewController.swift
//  TabBarController
//
//  Created by Barbara Correia on 25/04/2019.
//  Copyright © 2019 Barbara Correia. All rights reserved.
//

import UIKit
import Bar

class ViewController: UIViewController {
    
    @IBOutlet weak var tabBar: Bar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tab1 = Bar.Tab(image: UIImage(named: "hammer"), title: "11111111111111111111111111")
        let tab2 = Bar.Tab(image: UIImage(named: "hammer"), title: "222")
        let tab3 = Bar.Tab(image: UIImage(named: "hammer"), title: "333")
        
        tabBar.add(items: [tab1, tab2, tab3])
    }
}

