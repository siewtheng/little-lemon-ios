//
//  Search.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 29/4/2024.
//

import Foundation
import CoreData

struct PredicateUtility {
    
    // search
    static func searchPredicate(for searchText: String) -> NSPredicate {
        return searchText.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
    
    // category
    static func categoryPredicate(for category: String?) -> NSPredicate {
        guard let category = category, category != "all" else { return NSPredicate(value: true) }
        return NSPredicate(format: "category == %@", category)
    }
    
    // both search and category
    static func buildPredicate(for searchText: String, category: String?) -> NSPredicate {
        let searchPredicate = searchPredicate(for: searchText)
        let categoryPredicate = categoryPredicate(for: category)
        return NSCompoundPredicate(andPredicateWithSubpredicates: [searchPredicate, categoryPredicate])
    }
}
