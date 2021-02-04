//
//  UIFont+PreferredFont.swift
//
//  Created by Franklyn Weber on 08/07/2020.
//

import UIKit


extension UIFont {
    
    class func preferredFont(forFamily family: String? = nil,
                             style: UIFont.TextStyle,
                             weight: UIFont.Weight = .regular) -> UIFont {
        
        let fontDescriptor = self.fontDescriptor(for: style)
        
        let attributes: [UIFontDescriptor.AttributeName : Any] = [
            .family: family ?? UIFont.systemFont(ofSize: 12).familyName,
            .traits: [UIFontDescriptor.TraitKey.weight: weight],
            .size: fontDescriptor.pointSize
        ]
        
        let customFontDescriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: customFontDescriptor, size: 0)
    }
    
    private static func fontDescriptor(for textStyle: UIFont.TextStyle) -> UIFontDescriptor {
        let traitCollection = UITraitCollection(preferredContentSizeCategory: UIContentSizeCategory.large)
        return .preferredFontDescriptor(withTextStyle: textStyle, compatibleWith: traitCollection)
    }
}
