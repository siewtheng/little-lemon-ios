//
//  InitialsImage.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 29/4/2024.
//

import Foundation
import UIKit

extension UIImage {
    static func makeInitialsImage(initials: String, size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { context in
            UIColor.lightGray.setFill()
            context.fill(CGRect(origin: .zero, size: size))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let font = UIFont.systemFont(ofSize: size.height / 3)
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.white
            ]
            
            let text = NSAttributedString(string: initials, attributes: attributes)
            let textRect = CGRect(x: 0, y: (size.height - font.lineHeight) / 2, width: size.width, height: size.height)
            text.draw(in: textRect)
        }
        return image
    }
}
