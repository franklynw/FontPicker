//
//  FontPicker.swift
//  HandyList
//
//  Created by Franklyn Weber on 28/01/2021.
//

import SwiftUI
import HalfASheet


public struct FontPicker: View {
    
    @Binding private var isPresented: Bool
    @Binding private var selection: String
    
    internal var userFontNames: [String]?
    internal var additionalFontNames: [String] = []
    
    // these fonts render in an odd way, with tops or bottoms being chopped off, or being nonsense for our purposes (such as symbols)
    // However, if the user wants them, they just need to specify [] as the excludedFontNames
    internal var excludedFontNames = [
        "Bodoni Ornaments",
        "Damascus",
        "Hiragino"
    ]
    
    internal var backgroundColor: UIColor = .systemBackground
    internal var _dismissOnSelection = true
    internal var height: HalfASheetHeight?
    
    
    /// Initialiser
    /// - Parameters:
    ///   - isPresented: binding to a Bool which controls whether or not to show the picker
    ///   - selected: binding to a String for the selected font name
    public init(isPresented: Binding<Bool>, selected: Binding<String>) {
        _isPresented = isPresented
        _selection = selected
    }
    
    public var body: some View {
        
        HalfASheet(isPresented: $isPresented) {
            
            VStack {
                
                Text(NSLocalizedString("Font", bundle: Bundle.module, comment: "Font"))
                    .font(Font.headline.weight(.semibold))
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .lineLimit(1)
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(backgroundColor.withAlphaComponent(0.4).equivalentColorWithNoTransparency))
                    
                    List {
                        ForEach(fontNamesToDisplay(), id: \.self) { fontName in
                            
                            HStack {
                                Text(fontName)
                                    .customFont(name: fontName)
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selection = fontName
                                if _dismissOnSelection {
                                    isPresented = false
                                }
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                }
            }
            .onAppear {
                NotificationCenter.default.post(name: .fontPickerAppeared, object: self)
            }
            .onDisappear {
                NotificationCenter.default.post(name: .fontPickerDisappeared, object: self)
            }
        }
        .height(height ?? .proportional(0.84))
        .contentInsets(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16))
        .backgroundColor(backgroundColor)
        .closeButtonColor(UIColor.black.withAlphaComponent(0.3))
    }
    
    private func fontNamesToDisplay() -> [String] {
        
        if let userFontNames = userFontNames {
            return userFontNames
        }
        
        let fontNames = UIFont.familyNames.sorted().filter { !excludedFontNames.contains(where: $0.contains) }
        
        return (fontNames + additionalFontNames).sorted()
    }
}
