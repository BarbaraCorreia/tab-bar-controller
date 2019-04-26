//
//  ViewController.swift
//  TabBarController
//
//  Created by Barbara Correia on 25/04/2019.
//  Copyright © 2019 Barbara Correia. All rights reserved.
//

import UIKit
import Bar

class TabBarViewController: UIViewController {
    
    var tabBar: Bar!
    var containerView: UIView!
    
    private let pageViewController = PageViewController()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        
        tabBar = Bar()
        tabBar.setContentHuggingPriority(UILayoutPriority(rawValue: 753), for: NSLayoutConstraint.Axis.vertical)
        view.addSubview(tabBar)
        
        containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.setContentHuggingPriority(UILayoutPriority(rawValue: 751), for: NSLayoutConstraint.Axis.vertical)
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            tabBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: tabBar.bottomAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tab1 = Bar.Tab(image: UIImage(named: "hammer"), title: "11111111111111111111111111")
        let tab2 = Bar.Tab(image: UIImage(named: "hammer"), title: "222")
        let tab3 = Bar.Tab(image: UIImage(named: "hammer"), title: "333")
        let tab4 = Bar.Tab(image: UIImage(named: "hammer"), title: "333")
        
        tabBar.add(items: [tab1, tab2, tab3, tab4])
        tabBar.animated = true
        
        addChild(pageViewController)
        containerView.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.setViewControllers([], direction: .forward, animated: false, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageViewController.view.frame = containerView.bounds
    }
}

