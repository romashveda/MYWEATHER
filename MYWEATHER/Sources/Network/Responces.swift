//
//  Responces.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/20/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import Foundation

struct City: Codable {
    let country: String
    let name: String
    let lat: String
    let lng: String
}

struct WeatherResponce: Codable {
    let weather: [Weather]
    let main: MainData
    let id: Double
    let name: String
    let cod: Int
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
