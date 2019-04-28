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
    
    private let pageViewController = UIPageViewController()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        
        pageViewController.view.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        
        tabBar = Bar()
        tabBar.delegate = self
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
            tabBar.heightAnchor.constraint(equalToConstant: 70),
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
        
        tabBar.add(items: [tab1, tab2, tab3])
        tabBar.animated = true
        
        addChild(pageViewController)
        containerView.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageViewController.view.frame = containerView.bounds
    }
}

extension TabBarViewController: BarDelegate {
    
    func bar(_ bar: Bar, willSelectIndex index: Int) {}
    
    func bar(_ bar: Bar, didSelectIndex index: Int) {
        
        var viewController: UIViewController
        
        switch index {
        case 0:
            viewController = UIViewController()
            viewController.view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        case 1:
            viewController = UIViewController()
            viewController.view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        default:
            viewController = UIViewController()
            viewController.view.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
        
        pageViewController.setViewControllers([viewController], direction: .forward, animated: false, completion: nil)
    }
}

