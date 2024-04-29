//
//  Sorting.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 29/4/2024.
//

import Foundation
import CoreData

struct SortUtilities {
    // sort ascending by title
    static func titleSortDescriptor(ascending: Bool = true) -> NSSortDescriptor {
        return NSSortDescriptor(key: "title", ascending: ascending, selector: #selector(NSString.localizedStandardCompare(_:)))
    }
    
}
