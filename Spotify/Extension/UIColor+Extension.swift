//
//  UIColor+Extension.swift
//  Spotify
//
//  Created by Felix Liman on 08/12/24.
//

import UIKit

extension UIColor {
    convenience init(hexa: Int, alpha: CGFloat = 1) {
        let mask = 0xFF
        let limit: CGFloat = 255.0
        let red = CGFloat((hexa >> 16) & mask) / limit
        let green = CGFloat((hexa >> 8) & mask) / limit
        let blue = CGFloat(hexa & mask) / limit
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
