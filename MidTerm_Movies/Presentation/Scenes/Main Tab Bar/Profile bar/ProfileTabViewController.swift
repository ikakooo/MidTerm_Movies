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
    
    @IBAction func onLogOutButtonClick(_ sender: Any) {
        UDManager.markUserAsLoggedOut()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
