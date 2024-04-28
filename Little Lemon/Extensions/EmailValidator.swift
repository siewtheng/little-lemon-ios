//
//  EmailValidator.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 28/4/2024.
//

import Foundation

class EmailValidator {
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

