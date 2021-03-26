//
//  UIColor+Extensions.swift
//  
//
//  Created by Franklyn Weber on 25/03/2021.
//

import UIKit


extension UIColor {
    
    // this is to get the color when blended with a white background when alpha is < 1
    var equivalentColorWithNoTransparency: UIColor {

        guard let components = self.cgColor.components?.map({ $0 * 255 }) else { return self }

        if components.count == 4 {
            let alpha = 1 - components[3] / 255
            let red = (255 - components[0]) * alpha + components[0]
            let green = (255 - components[1]) * alpha + components[1]
            let blue = (255 - components[2]) * alpha + components[2]
            let color = UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
            return color
        } else {
            let alpha = 1 - components[1] / 255
            let gray = (255 - components[0]) * alpha + components[0]
            let color = UIColor(red: gray / 255, green: gray / 255, blue: gray / 255, alpha: 1)
            return color
        }
    }
}
