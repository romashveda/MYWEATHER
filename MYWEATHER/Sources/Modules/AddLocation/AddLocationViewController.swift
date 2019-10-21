//
//  AddLocationViewController.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/19/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

final class AddLocationViewController: UIViewController, Storyboarded, Coordinated {
    
    weak var coordinator: MainCoordinator!
    lazy var locationManager: CLLocationManager = {
        let location = CLLocationManager()
        location.delegate = self
        location.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        location.activityType = .automotiveNavigation
        location.distanceFilter = 10.0
        return location
    }()
    
    @IBOutlet private var tableView: UITableView!
    
    @IBAction func getCurrentLocation(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredCities: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.delegate = self
    }

    private func filterContentForSearchText(_ searchText: String) {
        filteredCities = coordinator.allCities.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        tableView.reloadData()
    }
}

extension AddLocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let city = filteredCities[indexPath.row]
        cell.textLabel?.text = city.name + " " + city.country
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newCity = filteredCities[indexPath.row]
        if coordinator.selectedPlaces.contains(newCity) {
            coordinator.presentAlertWithMessage(message: "This location added already")
        } else {
           coordinator.selectedPlaces.append(newCity)
           coordinator.popViewController()
        }
    }
}

extension AddLocationViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else { return }
        filterContentForSearchText(searchBarText)
    }
}

extension AddLocationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        guard let searchBarText = searchController.searchBar.text else { return }
        filterContentForSearchText(searchBarText)
    }
}

extension AddLocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let city = City(country: "MyLocation", name: "", lat: locValue.latitude.description, lng: locValue.longitude.description)
        if coordinator.selectedPlaces.contains(city) {
            coordinator.presentAlertWithMessage(message: "This location added already")
        } else {
            coordinator.selectedPlaces.append(city)
            locationManager.stopUpdatingLocation()
            coordinator.popViewController()
        }
    }
}
