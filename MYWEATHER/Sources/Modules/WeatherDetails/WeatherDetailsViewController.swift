//
//  WeatherDetailsViewController.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/19/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit

final class WeatherDetailsViewController: UIViewController, Storyboarded, Coordinated {
    
    weak var coordinator: MainCoordinator!
    var city: City!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
  
}
