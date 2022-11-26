//
//  RootViewController.swift
//  ReRolut
//
//  Created by reromac on 2022-11-25.
//

// TODO: - pakeisti logo paveiksliuka i ReRolut
// TODO: - userio issaugojimas ir visa userMAnager logika per klases User ir userManager
// TODO: - userio validavimas ir erroru alertai

import UIKit

class RootViewController: UIViewController {
    
    // enumas, kuriame nurodoma, kad pradinis langas tures dvi busenas (segmentus): registravimosi ir prisijungimo
    enum Segment {
        case register
        case login
    }
    
    
    
    @IBOutlet private weak var userLoginSegmentedController: UISegmentedControl!
    
    @IBOutlet private weak var enterUsernameTextField: UITextField!
    
    @IBOutlet private weak var enterPasswordTextField: UITextField!
    
    @IBOutlet private weak var retypePasswordTextField: UITextField!
    
    @IBOutlet private weak var loginButton: UIButton!
    
    var currentSegment: Segment = .register
    //TODO: sukurus klases reikes atkomentuoti ir implementuoti userio patikrinimo ir perdavimo logika
    //    let userManager = UserManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //textfield delegatai, bandymui dissmisinti klaviatura
        enterUsernameTextField.delegate = self
        enterPasswordTextField.delegate = self
        retypePasswordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    /* segmentinio kontrolerio veikimo f-ja. joje atsizvelgiant i pasirinkta busena (.login ar .register) parodoma ar bus isvedamas passwordo konfirminimo teksto laukas. Taip pat switcho pagalba, atsizvelgiant i segmenta, parenkamas rodomo labelio ant mygtuko uzrasas */
    @IBAction func userLoginSegmentedControllerStateChanged(_ sender: Any) {
        
        if userLoginSegmentedController.selectedSegmentIndex == 0 {
            currentSegment = .register
        } else if userLoginSegmentedController.selectedSegmentIndex == 1 {
            currentSegment = .login
        }
        
        /* jeigu pasirinktas segmentas yra .login tai passwordo retypinimo textfieldas nerodomas */
        retypePasswordTextField.isHidden = currentSegment != .register
        
        
        // switchas kurio pagalba isvedamas uzrasas ant mygtuko:
        switch currentSegment {
        case .register:
            loginButton.setTitle("REGISTER", for: .normal)
        case .login:
            loginButton.setTitle("LOGIN", for: .normal)
            
            
            //patikrinimas kuris segmentas pasirinktas (nebutinas)
            print(userLoginSegmentedController.selectedSegmentIndex)
        }
        
    }
    
    /* mygtuko paspaudimas - atliekamos f-jos:
     */
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        //patikrinimas ar veikia duomenu ivedimas (nebutinas)
        print(enterUsernameTextField.text!)
        print(enterPasswordTextField.text!)
        
        // navigation viewControleris ir perejimas i kita VC
        let transfersViewController = TransfersViewController()
        navigationController?.pushViewController(transfersViewController, animated: true)
        
    }
    
}
    // extensionas, kad butu galima dissmissinti keyboard (1-as budas)
extension UIViewController: UITextFieldDelegate {
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }


