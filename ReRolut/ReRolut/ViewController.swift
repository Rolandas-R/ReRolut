//
//  ViewController.swift
//  ReRolut
//
//  Created by reromac on 2022-11-25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var imageViewPersonLogo: UIImageView!
    
    @IBOutlet weak var userLoginSegmentedController: UISegmentedControl!
    
    @IBOutlet private weak var enterUsernameTextField: UITextField!
    
    @IBOutlet private weak var enterPasswordTextField: UITextField!
    
    @IBOutlet private weak var retypePasswordTextField: UITextField!
    
    @IBOutlet private weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func userLoginSegmentedControllerStateChanged(_ sender: Any) {
        
        //patikrinimas kuris segmentas pasirinktas
        print(userLoginSegmentedController.selectedSegmentIndex)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        //patikrinimas ar veikia duomenu ivedimas
        print(enterUsernameTextField.text!)
        print(enterPasswordTextField.text!)
    }
    


}

