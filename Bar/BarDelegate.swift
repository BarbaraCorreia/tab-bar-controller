//
//  BarDelegate.swift
//  Bar
//
//  Created by Barbara Correia on 25/04/2019.
//  Copyright © 2019 Barbara Correia. All rights reserved.
//

import Foundation

public protocol BarDelegate: class {
    func bar(_ bar: Bar, willSelectIndex: Int)
    func bar(_ bar: Bar, didSelectIndex: Int)
}
