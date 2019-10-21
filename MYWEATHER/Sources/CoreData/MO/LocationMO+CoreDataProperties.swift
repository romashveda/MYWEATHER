//
//  LocationMO+CoreDataProperties.swift
//  
//
//  Created by Roman Shveda on 10/21/19.
//
//

import Foundation
import CoreData


extension LocationMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationMO> {
        return NSFetchRequest<LocationMO>(entityName: "LocationMO")
    }

    @NSManaged public var longtitude: Double
    @NSManaged public var latitude: Double

}
