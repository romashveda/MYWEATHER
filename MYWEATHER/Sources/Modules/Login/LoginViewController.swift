//
//  LoginViewController.swift
//  MYWEATHER
//
//  Created by Roman Shveda on 10/19/19.
//  Copyright © 2019 Roman Shveda. All rights reserved.
//

import UIKit
import GoogleSignIn

final class LoginViewController: UIViewController, Storyboarded, Coordinated {

    @IBOutlet weak var signInButton: GIDSignInButton!
    
    @IBAction func signIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    weak var coordinator: MainCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        signInButton.layer.cornerRadius = 10
    }
    
}
