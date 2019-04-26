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
    
    var tabBar: Bar!
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        
        tabBar = Bar()
        view.addSubview(tabBar)
        NSLayoutConstraint.activate([
            tabBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tab1 = Bar.Tab(image: UIImage(named: "hammer"), title: "11111111111111111111111111")
        let tab2 = Bar.Tab(image: UIImage(named: "hammer"), title: "222")
        let tab3 = Bar.Tab(image: UIImage(named: "hammer"), title: "333")
        let tab4 = Bar.Tab(image: UIImage(named: "hammer"), title: "333")
        
        tabBar.add(items: [tab1, tab2, tab3, tab4])
        tabBar.animated = true
    }
}

