//
//  LocationsViewController.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/19/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit

final class LocationsViewController: UIViewController, Storyboarded, Coordinated {
    
    weak var coordinator: MainCoordinator!
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var addLocationButton: UIButton!
    
    @IBAction func addLocationTapped(_ sender: UIButton) {
        coordinator.openAddLocations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: LocationTVCell.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
}

extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coordinator.selectedPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.cell(cellType: LocationTVCell.self) else { return UITableViewCell() }
        let city = coordinator.selectedPlaces[indexPath.row]
        cell.nameLabel.text = city.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = coordinator.selectedPlaces[indexPath.row]
        coordinator.openWeatherDetails(city: selectedCity)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
