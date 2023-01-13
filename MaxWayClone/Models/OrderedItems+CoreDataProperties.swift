//
//  OrderedItems+CoreDataProperties.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 22/12/22.
//
//

import Foundation
import CoreData


extension OrderedItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderedItems> {
        return NSFetchRequest<OrderedItems>(entityName: "OrderedItems")
    }

    @NSManaged public var foodImageName: String?
    @NSManaged public var foodName: String?
    @NSManaged public var foodPrice: Int64
    @NSManaged public var numberOfItems: Int64

}

extension OrderedItems : Identifiable {

}
