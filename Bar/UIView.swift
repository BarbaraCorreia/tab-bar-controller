//
//  UIView.swift
//  Bar
//
//  Created by Barbara Correia on 26/04/2019.
//  Copyright © 2019 Barbara Correia. All rights reserved.
//

import UIKit

extension UIView {
    
    func constraint(withIdentifier identifier: String) -> NSLayoutConstraint? {
        return constraints.first(where: { $0.identifier == identifier })
    }
}
