//
//  BaseNetworkClient.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/20/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import Foundation
import Moya
import Alamofire

typealias CompletionBlockWithData = (_ isSuccess: Bool, _ error: String?, _ data: Any?) -> ()
typealias APIResponseClosure<T: Codable> = (_ isSuccess: Bool, _ error: String?, _ object: T?) -> ()

class BaseNetworkClient: NSObject {
    
    static private let citiesURL = "https://raw.githubusercontent.com/lutangar/cities.json/master/cities.json"
    static private let imageURL = "https://openweathermap.org/img/wn/"
    static private let imageResolution = "@2x.png"
    
    static func requestWithJSONEncoding(baseURL: String, stringURL: String? = nil, method: HTTPMethod, parameters: [String: Any]? = nil, pathParameters: [String: String] = [:], result: @escaping CompletionBlockWithData) {
        request(baseURL: baseURL, stringURL: stringURL, method: method, encoding: JSONEncoding.default, parameters: parameters, pathParameters: pathParameters,result: result)
    }
    
    private static func request(baseURL: String, stringURL: String? = nil, method: HTTPMethod, encoding: ParameterEncoding, parameters: [String: Any]? = nil, pathParameters: [String: String] = [:], result: @escaping CompletionBlockWithData) {
        let fullURL: String = baseURL.appending(stringURL ?? "")
        var components: URLComponents?
        if pathParameters.count > 0, let url = URL(string: fullURL) {
            components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = pathParameters.map({ URLQueryItem(name: String($0), value: String($1)) })
        }
        let url: URLConvertible = components == nil ? fullURL : components!.url!
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding).responseJSON { (response) in
            guard let code = response.response?.statusCode else { return }
            if let error = response.error as? Alamofire.AFError, error.isResponseSerializationError {
                result(code == 200, nil, nil)
            }
            result(response.result.isSuccess, response.error?.localizedDescription, response.result.value)
        }
    }
    
    static func getImage(from imageName: String, completion: @escaping (_: UIImage?) -> () ) {
        let imageURLString = imageURL + imageName + imageResolution
        guard let url = URL(string: imageURLString) else { return }
        getImage(imageName: imageName, from: url) { image in
            completion(image)
        }
    }
    
    static func getImage(imageName: String, from url: URL, completion: @escaping (_: UIImage?) -> ()) {
        if let image = CacheManager.shared.get(for: imageName) {
            completion(image)
        }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            CacheManager.shared.save(image: image, stringURL: imageName)
            completion(image)
        }
    }
    
    static func getCities(completion: @escaping (_: [City]) -> ()) {
        guard let url = URL(string: citiesURL) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url), let cityArray = try? JSONDecoder().decode([City].self, from: data) else {
                completion([])
                return
            }
            completion(cityArray)
        }
    }

}
