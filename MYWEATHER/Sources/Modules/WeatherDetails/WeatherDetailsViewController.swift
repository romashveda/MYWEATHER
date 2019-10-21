//
//  WeatherDetailsViewController.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/19/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit
// TODO: show all weatherData properties
final class WeatherDetailsViewController: UIViewController, Storyboarded, Coordinated {
    
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView!
    
    weak var coordinator: MainCoordinator!
    var city: CityMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCityData()
    }
    
  
    func getCityData() {
        WeatherAPIManager.getWeatherData(for: city) { [weak self] (_, errorString, responce) in
            guard let strongSelf = self, errorString == nil else {
                self?.coordinator.presentAlertWithMessage(message: errorString!)
                return
            }
            guard let responce = responce else { return }
            if let imageString = responce.weather.first?.icon {
                WeatherAPIManager.getImage(from: imageString) { image in
                    DispatchQueue.main.async {
                        strongSelf.iconImageView.image = image
                    }
                }
            }
            DispatchQueue.main.async {
                let intValue = Int(responce.main.temp - 273.15)
                strongSelf.temperatureLabel.text = intValue.description
                strongSelf.cityNameLabel.text = responce.name + "," + responce.sys.country
                strongSelf.descriptionLabel.text = responce.weather.first?.description
            }
        }
    }
}
