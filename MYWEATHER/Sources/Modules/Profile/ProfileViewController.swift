//
//  ProfileViewController.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/19/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit
import GoogleSignIn

final class ProfileViewController: UIViewController, Storyboarded, Coordinated {
    
    @IBOutlet private var avatarImage: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!
    
    weak var coordinator: MainCoordinator!
    
    @IBAction func logOut(_ sender: UIButton) {
        KeychainServices.saveToken(token: "")
        GIDSignIn.sharedInstance().signOut()
        CacheManager.shared.clearCache()
        coordinator.openLogin()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImage.layer.cornerRadius = avatarImage.bounds.height / 2
        guard let profile = GIDSignIn.sharedInstance()?.currentUser?.profile else { return }
        nameLabel.text = profile.givenName + profile.familyName
        emailLabel.text = profile.email
        if let url = profile.imageURL(withDimension: 120) {
            BaseNetworkClient.getImage(imageName: "avatar", from: url) { [weak self] image in
                DispatchQueue.main.async {
                    self?.avatarImage.image = image
                }
            }
        }
    }
    
}
