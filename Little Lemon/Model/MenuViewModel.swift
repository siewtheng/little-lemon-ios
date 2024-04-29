//
//  MenuViewModel.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 29/4/2024.
//

import Foundation
import SwiftUI

class MenuViewModel: ObservableObject {
    @Published var categories: [String] = ["all", "mains", "starters", "desserts"]
    @Published var selectedCategory: String = "all"

    func selectCategory(_ category: String) {
        selectedCategory = category
    }

    func isSelected(category: String) -> Bool {
        return selectedCategory == category
    }

    func categoryPredicate() -> NSPredicate? {
        guard selectedCategory != "all" else { return NSPredicate(value: true) }
        return NSPredicate(format: "category == %@", selectedCategory)
    }
}

