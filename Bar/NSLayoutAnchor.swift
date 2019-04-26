//
//  NSLayoutAnchor.swift
//  myCity
//
//  Created by Barbara Correia on 19/04/2018.
//  Copyright © 2018 blissapplications. All rights reserved.
//

import UIKit

@objc extension NSLayoutAnchor {
    
    func constraint(equalTo anchor: NSLayoutAnchor, constant: CGFloat = 0, identifier: String) -> NSLayoutConstraint {
        let constraint = self.constraint(equalTo: anchor, constant: constant)
        constraint.identifier = identifier
        return constraint
    }
}

@objc extension NSLayoutDimension {
    
    func constraint(equalToConstant constant: CGFloat, identifier: String) -> NSLayoutConstraint {
        let constraint = self.constraint(equalToConstant: constant)
        constraint.identifier = identifier
        return constraint
    }
}
