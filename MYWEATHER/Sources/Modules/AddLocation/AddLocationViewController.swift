//
//  AddLocationViewController.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/19/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit

final class AddLocationViewController: UIViewController, Storyboarded, Coordinated {
    
    weak var coordinator: MainCoordinator!
    
    @IBOutlet private var tableView: UITableView!
    
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
        filteredCities = City.cities().filter({ $0.name.lowercased().contains(searchText.lowercased()) })
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
        coordinator.selectedPlaces.append(newCity)
        coordinator.popViewController()
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
