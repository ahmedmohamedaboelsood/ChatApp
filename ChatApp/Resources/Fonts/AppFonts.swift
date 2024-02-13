//
//  AppFonts.swift
//  ChatApp
//
//  Created by Ahmed Abo Elsood on 13/02/2024.
//

import UIKit

enum AppFonts{
    case almarai(fontStyle:AppFontStyle)
}

extension AppFonts {
    enum AppFontStyle {
        case bold(size:CGFloat)
        case regular(size:CGFloat)
        case light(size:CGFloat)
        case extraBold(size:CGFloat)
    }
    
    var font : UIFont{
        switch self{
        case .almarai(fontStyle: let fontStyle):
            return almaraiFontStyle(fontStyle) ?? UIFont.systemFont(ofSize: 20)
        }
    }
    
    private func almaraiFontStyle( _ fontStyle : AppFontStyle)->UIFont?{
        switch fontStyle{
        case .bold(let size):
            return UIFont(name: "Almarai-Bold", size: size)
        case .light(let size):
            return UIFont(name: "Almarai-Light", size: size)
        case .extraBold(let size):
            return UIFont(name: "Almarai-ExtraBold", size: size)
        case .regular(let size):
            return UIFont(name: "Almarai-Regular", size: size)
        }
    }
}
