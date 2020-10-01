//
//  Item+CoreDataProperties.swift
//  MyWardrobe
//
//  Created by elliott kung on 2020-10-01.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var itemBrand: String?
    @NSManaged public var itemCategory: String?
    @NSManaged public var itemColor: String?
    @NSManaged public var itemImage: Data?
    @NSManaged public var itemSeason: String?
    @NSManaged public var itemSubCategory: String?

}

extension Item : Identifiable {

}
