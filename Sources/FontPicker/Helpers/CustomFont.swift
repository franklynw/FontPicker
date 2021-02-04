//
//  CustomFont.swift
//
//  Created by Franklyn on 25/06/2019.
//  Copyright © 2019 Franklyn. All rights reserved.
//

import SwiftUI


struct CustomFont: ViewModifier {

    let name: String
    let size: CGFloat?
    let style: Font.TextStyle?
    let weight: Font.Weight
    let maxSize: CGFloat?

    init(name: String, size: CGFloat? = nil, weight: Font.Weight = .regular, relativeTo style: Font.TextStyle? = nil) {
        self.name = name
        self.style = style
        self.size = size
        self.weight = weight
        maxSize = nil
    }
    
    init(name: String, weight: Font.Weight = .regular, relativeTo style: Font.TextStyle, maxSize: CGFloat) {
        self.name = name
        self.weight = weight
        self.maxSize = maxSize
        self.style = style
        size = nil
    }

    
    /// Will trigger the refresh of the view when the ContentSizeCategory changes.
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory

    func body(content: Content) -> some View {
        
        if let maxSize = maxSize, let style = style {
            let fontSize = min(Self.textSize(for: style), maxSize)
            return content.font(Font.custom(self.name, size: Self.scaledSize(for: fontSize, style: style)).weight(weight))
        }

        if let size = self.size {
            if let style = style {
                return content.font(Font.custom(name, size: size, relativeTo: style).weight(weight))
            } else {
                return content.font(Font.custom(name, size: size).weight(weight))
            }
        }

        guard let style = self.style else {
            return content.font(Font.custom(name, size: Self.textSize(for: .body)).weight(weight))
        }
        guard let size = self.fontSizes[style] else {
            return content.font(Font.custom(name, size: Self.textSize(for: .body)).weight(weight))
        }

        return content.font(Font.custom(self.name, size: size, relativeTo: .body).weight(weight))
    }


    private let fontSizes: [Font.TextStyle: CGFloat] = [
        .largeTitle: 34,
        .title: 28,
        .title2: 22,
        .title3: 20,
        .headline: 17,
        .body: 17,
        .callout: 16,
        .subheadline: 15,
        .footnote: 13,
        .caption: 12,
        .caption2: 11
    ]
    
    private static func scaledSize(for size: CGFloat, style: Font.TextStyle) -> CGFloat {
        let scale = UIFontMetrics.default.scaledValue(for: size)
        return size * size / scale
    }
    
    private static func textSize(for textStyle: Font.TextStyle) -> CGFloat {
        return UIFont.preferredFont(style: textStyle.uiStyle).pointSize
    }
}


extension Text {

    func customFont(name: String, size: CGFloat? = nil, weight: Font.Weight = .regular, relativeTo style: Font.TextStyle? = nil) -> ModifiedContent<Self, CustomFont> {
        return modifier(CustomFont(name: name, size: size, weight: weight, relativeTo: style))
    }

    func customFont(name: String, weight: Font.Weight = .regular, relativeTo style: Font.TextStyle, maxSize: CGFloat) -> ModifiedContent<Self, CustomFont> {
        return modifier(CustomFont(name: name, weight: weight, relativeTo: style, maxSize: maxSize))
    }
}
