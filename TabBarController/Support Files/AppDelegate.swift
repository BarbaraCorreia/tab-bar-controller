//
//  AppDelegate.swift
//  TabBarController
//
//  Created by Barbara Correia on 25/04/2019.
//  Copyright © 2019 Barbara Correia. All rights reserved.
//

import UIKit
import Bar

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let item1 = Bar.Tab(image: UIImage(named: "hammer"), title: "11111111111111111111111111")
        let item2 = Bar.Tab(image: UIImage(named: "hammer"), title: "222")
        let item3 = Bar.Tab(image: UIImage(named: "hammer"), title: "333")
        let item4 = Bar.Tab(image: UIImage(named: "hammer"), title: "11111111111111111111111111")
        let item5 = Bar.Tab(image: UIImage(named: "hammer"), title: "222")
        let item6 = Bar.Tab(image: UIImage(named: "hammer"), title: "333")
        
        let vc1 = UIViewController()
        vc1.view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        let vc2 = UIViewController()
        vc2.view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        let vc3 = UIViewController()
        vc3.view.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        let vc4 = UIViewController()
        vc4.view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        let vc5 = UIViewController()
        vc5.view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        let vc6 = UIViewController()
        vc6.view.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        let tab1 = Tab(viewController: vc1, tab: item1)
        let tab2 = Tab(viewController: vc2, tab: item2)
        let tab3 = Tab(viewController: vc3, tab: item3)
        let tab4 = Tab(viewController: vc4, tab: item4)
        let tab5 = Tab(viewController: vc5, tab: item5)
        let tab6 = Tab(viewController: vc6, tab: item6)
        
        let viewController = TabBarViewController(tabs: [tab1, tab2, tab3, tab4, tab5, tab6])
//        viewController.animated = true
        
        window?.rootViewController = viewController
        
        return true
    }
}

