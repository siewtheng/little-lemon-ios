//
//  MenuData+CoreDataProperties.swift
//  Little Lemon
//
//  Created by Siew Theng Chun on 29/4/2024.
//
//

import Foundation
import CoreData


extension MenuData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MenuData> {
        return NSFetchRequest<MenuData>(entityName: "MenuData")
    }

    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var price: String?
    @NSManaged public var category: String?
    @NSManaged public var desc: String?

}

extension MenuData : Identifiable {

}
