//
//  UIColor+Ext.swift
//  FoodPin
//
//  Created by Öcalan on 05/03/2019.
//  Copyright © 2019 Froidefond Valentin. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let redValue = CGFloat(red) / 255.0
        let greenValue = CGFloat(green) / 255.0
        let blueValue = CGFloat(blue) / 255.0
        
        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
}

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
