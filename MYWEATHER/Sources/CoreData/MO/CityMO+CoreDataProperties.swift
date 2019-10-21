//
//  CityMO+CoreDataProperties.swift
//  
//
//  Created by Roman Shveda on 10/21/19.
//
//

import Foundation
import CoreData


extension CityMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityMO> {
        return NSFetchRequest<CityMO>(entityName: "CityMO")
    }

    @NSManaged public var country: String
    @NSManaged public var name: String
    @NSManaged public var lat: String
    @NSManaged public var lng: String
    @NSManaged public var id: Int64

}
