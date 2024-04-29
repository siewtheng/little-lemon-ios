//
//  PriceFormatting.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 29/4/2024.
//

import Foundation

extension String {
    
    func formattedAsCurrency(using currencyCode: String = "USD") -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = currencyCode
        
        if let priceNumber = Double(self) {
            return numberFormatter.string(from: NSNumber(value: priceNumber)) ?? "$0.00"
        } else {
            // default or error
            return "$0.00"
        }
    }
}
