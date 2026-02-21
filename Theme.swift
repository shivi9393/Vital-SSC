import SwiftUI

struct Theme {
    static let background = Color.black
    static let surface = Color(white: 0.1)
    static let textMain = Color.white
    static let textSecondary = Color(white: 0.7)
    
    static let accentTeal = Color(red: 0.0, green: 0.8, blue: 0.8)
    static let warningRed = Color(red: 0.9, green: 0.2, blue: 0.2)
    static let interactiveBlue = Color.blue
    
    // Large, highly legible fonts
    static let titleFont = Font.system(size: 34, weight: .bold, design: .default)
    static let stepFont = Font.system(size: 28, weight: .semibold, design: .default)
    static let bodyFont = Font.system(size: 22, weight: .regular, design: .default)
}
