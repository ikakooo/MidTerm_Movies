//
//  ProfileTabViewController.swift
//  MidTerm_Movies
//
//  Created by MacBook Pro on 26.10.21.
//

import UIKit

class ProfileTabViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func onLogOutButtonClick(_ sender: Any) {
        UDManager.markUserAsLoggedOut()
    }
}
