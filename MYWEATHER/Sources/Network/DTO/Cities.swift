//
//  Cities.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/20/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import Foundation

struct City: Decodable {
    let country: String
    let name: String
    let lat: String
    let lng: String
}

extension City {
    static func cities() -> [City] {
        guard let url = Bundle.main.url(forResource: "cities", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let cities = try? JSONDecoder().decode([City].self, from: data)
        else { return [] }
        return cities
    }
}
