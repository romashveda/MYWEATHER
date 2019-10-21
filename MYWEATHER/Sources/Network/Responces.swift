//
//  Responces.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/20/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import Foundation

struct City: Codable, Equatable {
    let country: String
    let name: String
    let lat: String
    let lng: String
    
    static func ==(lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name && lhs.country == rhs.country
    }
}

struct WeatherResponce: Codable {
    let weather: [Weather]
    let main: MainData
    let sys: SYSData
    let id: Double
    let name: String
    let cod: Int
}
struct SYSData: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainData: Codable {
    let temp: Double
    let pressure: Double
    let humidity: Double
    let temp_min: Double
    let temp_max: Double
}
