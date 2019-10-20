//
//  BaseNetworkClient.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/20/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import Foundation
import Moya

class BaseNetworkClient {
    let mainURL = "api.openweathermap.org/data/2.5/weather?"
    let citiesJson = "https://raw.githubusercontent.com/lutangar/cities.json/master/cities.json"
}

enum Lutangar {
    case cities
}

extension Lutangar: TargetType {
    var baseURL: URL {
        return URL(string: "https://raw.githubusercontent.com/lutangar/cities.json/master/cities.json")!
    }
    
    var path: String {
        return "/master/cities.json"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
