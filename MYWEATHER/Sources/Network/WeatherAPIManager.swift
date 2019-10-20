//
//  WeatherAPIManager.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/20/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import Foundation

final class WeatherAPIManager: BaseNetworkClient {
    
    static private let weatherURL = "https://api.openweathermap.org/data/2.5/weather"
    static let apiKey = "7d5057aa2baae3c8b38374f3cbfc7233"
    
    static func getWeatherData(for city: City, completion: @escaping APIResponseClosure<WeatherResponce>) {
        var pathParameters: [String: String] = [:]
        pathParameters["q"] = "\(city.name),\(city.country)"
        pathParameters["APPID"] = apiKey
        requestWithJSONEncoding(baseURL: weatherURL, method: .get, pathParameters: pathParameters) { (success, errorString, dataAny) in
            guard success, errorString == nil else {
                completion(false, errorString!, nil)
                return
            }
            guard let jsonData = dataAny as? [String: AnyObject], let data = try? JSONSerialization.data(withJSONObject: jsonData), let response = try? JSONDecoder().decode(WeatherResponce.self, from: data) else {
                completion(false, "decoding error", nil)
                return
            }
            completion(true, nil, response)
        }
    }
    
//    static func getCities(completion: @escaping APIResponseClosure<[City]>) {
//        requestWithJSONEncoding(baseURL: citiesURL, method: .get) { (success, errorString, dataAny) in
//            guard success, errorString == nil else {
//                completion(false, errorString!, nil)
//                return
//            }
//            guard let jsonData = dataAny as? [String: AnyObject], let data = try? JSONSerialization.data(withJSONObject: jsonData), let response = try? JSONDecoder().decode([City].self, from: data) else {
//                completion(false, "decoding error", nil)
//                return
//            }
//            completion(true, nil, response)
//        }
//    }
}
