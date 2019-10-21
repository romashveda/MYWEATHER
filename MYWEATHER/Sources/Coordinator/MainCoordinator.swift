//
//  MainCoordinator.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/19/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit
import GoogleSignIn

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    init(navigationController: UINavigationController)
    func start()
}

final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
//    var user: GIDGoogleUser? = GIDSignIn.sharedInstance()?.currentUser
    var allCities: [City] = []
    var selectedPlaces: [City] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if KeychainServices.loadToken() != nil {
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            openLocations()
        } else {
            openLogin()
        }
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func presentAlertWithMessage(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style:  .default)
        alert.addAction(okAction)
        navigationController.present(alert, animated: true, completion: nil)
    }
    
    func openLogin() {
        let vc = LoginViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func openLocations() {
        WeatherAPIManager.getCities { [weak self] cityArray in
            self?.allCities = cityArray
        }
        let vc = LocationsViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func openAddLocations() {
        guard allCities.count != 0 else { return }
        let vc = AddLocationViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openWeatherDetails(city: City) {
        let vc = WeatherDetailsViewController.instantiate()
        vc.coordinator = self
        vc.city = city
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openProfile() {
        let vc = ProfileViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}
