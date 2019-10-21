//
//  CacheManager.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/21/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit

final class CacheManager {
    
    private let imageCache = NSCache<NSString, UIImage>()
    private var observer: NSObjectProtocol!
    static let shared = CacheManager()
    
    private init() {
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: nil, using: { [weak self] _ in
            self?.imageCache.removeAllObjects()
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(observer)
    }
    
    func save(image: UIImage, stringURL: String) {
        imageCache.setObject(image, forKey: NSString(string: stringURL))
    }
    
    func get(for stringURL: String) -> UIImage? {
        return imageCache.object(forKey: NSString(string: stringURL))
    }
    
    func clearCache() {
        imageCache.removeAllObjects()
    }
}
