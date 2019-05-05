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
    
    var animated = false
    
    private(set) var selectedIndex: Int = -1
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
        
        let layout = Bar.Layout()
        layout.alignment = .trailing
        
        tabBar = Bar()
        tabBar.layout = layout
        tabBar.delegate = self
        tabBar.setContentHuggingPriority(UILayoutPriority(rawValue: 753), for: NSLayoutConstraint.Axis.vertical)
        view.addSubview(tabBar)
        
        containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.setContentHuggingPriority(UILayoutPriority(rawValue: 751), for: NSLayoutConstraint.Axis.vertical)
        view.addSubview(containerView)
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
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
        tabBar.animated = animated
        
        selectPage(index: tabBar.selectedIndex)
    
        addChild(pageViewController)
        containerView.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectPage(index: selectedIndex)
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
        
        guard !tabs.isEmpty, index != selectedIndex, index >= 0, index < tabs.count else { return }
        
        let viewController = tabs[index].viewController
        let direction: UIPageViewController.NavigationDirection = index > selectedIndex ? .forward : .reverse
        pageViewController.setViewControllers([viewController], direction: direction, animated: animated, completion: nil)
        
        selectedIndex = index
    }
}

