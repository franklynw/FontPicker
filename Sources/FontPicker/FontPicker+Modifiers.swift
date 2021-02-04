//
//  File.swift
//  
//
//  Created by Franklyn Weber on 04/02/2021.
//

import SwiftUI


extension FontPicker {
    
    /// The color to use for the background of the picker
    /// - Parameter backgroundColor: a UIColor
    public func backgroundColor(_ backgroundColor: UIColor) -> Self {
        var copy = self
        copy.backgroundColor = backgroundColor
        return copy
    }
    
    /// Normally, selecting a font will dismiss the picker. Use this to disable that functionality (eg if you have a preview which shows how the font will look in context)
    public var disableDismissOnSelection: Self {
        var copy = self
        copy._dismissOnSelection = false
        return copy
    }
    
    /// Use this to display only the fonts you want
    /// - Parameter fontNames: the names of the fonts you want to display
    public func fontNames(_ fontNames: [String]) -> Self {
        var copy = self
        copy.userFontNames = fontNames
        return copy
    }
    
    /// Add your own fonts to the default list of those provided by the system
    /// - Parameter fontNames: the names of the fonts you want to add
    public func additionalFontNames(_ fontNames: [String]) -> Self {
        var copy = self
        copy.additionalFontNames = fontNames
        return copy
    }
    
    /// If there are any fonts you don't want to appear, specify them here. By default, "Bodoni Ornaments", "Damascus" & "Hiragino" are excluded as they render in an odd way, with bits chopped off.
    /// To reinstate them, specify an empty array here
    /// - Parameter fontNames: the names of the fonts you want to add
    public func excludedFontNames(_ fontNames: [String]) -> Self {
        var copy = self
        copy.excludedFontNames = fontNames
        return copy
    }
}


extension View {
    
    /// View extension in the style of .sheet - lacks a couple of customisation options. If more flexibility is required, use FontPicker(...) directly, and apply the required modifiers
    /// - Parameters:
    ///   - isPresented: binding to a Bool which controls whether or not to show the picker
    ///   - selected: binding to a String for the selected font name
    func fontPicker(isPresented: Binding<Bool>, selected: Binding<String>) -> some View {
        modifier(FontPickerPresentationModifier(content: { FontPicker(isPresented: isPresented, selected: selected)}))
    }
}


struct FontPickerPresentationModifier: ViewModifier {
    
    var content: () -> FontPicker
    
    init(@ViewBuilder content: @escaping () -> FontPicker) {
        self.content = content
    }
    
    func body(content: Content) -> some View {
        self.content()
    }
}
