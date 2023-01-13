//
//  Item+CoreDataProperties.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 10/12/22.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var foodImageName: String?
    @NSManaged public var foodName: String?
    @NSManaged public var foodPrice: Int64
    @NSManaged public var numberOfItems: Int64
    @NSManaged public var totalAmount: Int64

}

extension Item : Identifiable {

}
