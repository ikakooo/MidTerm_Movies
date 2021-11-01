//
//  LoginViewController.swift
//  MidTerm_Movies
//
//  Created by MacBook Pro on 29.10.21.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak private var emailFild: ShadowForUITextField!
    @IBOutlet weak private var passwordFild: ShadowForUITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction private func onLoginButtonClick(_ sender: Any) {
        let userName = emailFild.text ?? ""
        let passWord = passwordFild.text ?? ""
        if userName.count > 8 && passWord.count > 8 {
            UDManager.saveUserAndMarkUserAsLoggedIn(user: User(username: userName, password: passWord))
          
            navigationController?.popToRootViewController( animated: false )
            let sb = UIStoryboard(name: "MainTabBarViewController", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "MainTabBarViewController")
            
            navigationController?.viewControllers.removeAll()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }else{
            print("Username and password must be more than 8 character")
        }
        
    }
}
