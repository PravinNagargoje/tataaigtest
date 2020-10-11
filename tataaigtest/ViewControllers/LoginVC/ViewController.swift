//
//  ViewController.swift
//  tataaigtest
//
//  Created by Admin on 10/10/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        if (!(emailAddressTextField.text!.isEmpty) && !passwordTextField.text!.isEmpty) {
            let homeScreenVC = HomeScreenVC()
            navigationController?.pushViewController(homeScreenVC, animated: true)
        } else {
            emailAddressTextField.text!.isEmpty ? showAlert(message: "Please enter email address") : showAlert(message: "Please enter password")
        }
    }
}

extension UIViewController {
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }
}
