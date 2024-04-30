//
//  ColorExtension.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 30/4/2024.
//

import Foundation
import SwiftUI

extension Color {
    static let primaryGreen = Color(hex: 0x495e57)
    static let primaryYellow = Color(hex: 0xf4ce14)
    static let secondaryOrange = Color(hex: 0xee9972)
    static let secondaryLightOrange = Color(hex: 0xfbdabb)
    static let background = Color(hex: 0xedefee)
    static let text = Color(hex: 0x333333)
    static let error = Color(hex: 0xe74c3c)
    
    init(hex: UInt, alpha: Double = 1) {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0x00FF00) >> 8) / 255.0
        let blue = Double(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}
