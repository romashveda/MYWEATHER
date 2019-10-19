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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
}

extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
