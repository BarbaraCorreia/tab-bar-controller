//
//  ViewController.swift
//  TabBarController
//
//  Created by Barbara Correia on 25/04/2019.
//  Copyright © 2019 Barbara Correia. All rights reserved.
//

import UIKit
import Bar

final class TabBarViewController: UIViewController {
    
    private(set) var tabs: [Tab] = []
    
    private var tabBar: Bar!
    private var containerView: UIView!
    private var pageViewController: UIPageViewController!
    
    convenience init(tabs: [Tab]) {
        self.init()
        self.tabs = tabs
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        
        tabBar = Bar()
        tabBar.delegate = self
        tabBar.setContentHuggingPriority(UILayoutPriority(rawValue: 753), for: NSLayoutConstraint.Axis.vertical)
        view.addSubview(tabBar)
        
        containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.setContentHuggingPriority(UILayoutPriority(rawValue: 751), for: NSLayoutConstraint.Axis.vertical)
        view.addSubview(containerView)
        
        pageViewController = UIPageViewController()
        
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
        
        tabBar.add(items: tabs.compactMap({ $0.tab }))
    
        addChild(pageViewController)
        containerView.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectPage(index: tabBar.selectedIndex)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageViewController.view.frame = containerView.bounds
    }
}

extension TabBarViewController: BarDelegate {
    
    func bar(_ bar: Bar, willSelectIndex index: Int) {}
    
    func bar(_ bar: Bar, didSelectIndex index: Int) {
        selectPage(index: index)
    }
}

private extension TabBarViewController {
    
    func selectPage(index: Int) {
        
        guard !tabs.isEmpty, index >= 0, index < tabs.count else { return }
        
        let viewController = tabs[index].viewController
        pageViewController.setViewControllers([viewController], direction: .forward, animated: false, completion: nil)
    }
}

