//
//  WeatherMO+CoreDataProperties.swift
//  
//
//  Created by Roman Shveda on 10/21/19.
//
//

import Foundation
import CoreData


extension WeatherMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherMO> {
        return NSFetchRequest<WeatherMO>(entityName: "WeatherMO")
    }

    @NSManaged public var temperature: Double
    @NSManaged public var descriptionString: String

}
