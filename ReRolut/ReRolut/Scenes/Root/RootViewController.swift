//
//  RootViewController.swift
//  ReRolut
//
//  Created by reromac on 2022-11-25.
//

// TODO: - pakeisti logo paveiksliuka i ReRolut


import UIKit

class RootViewController: UIViewController {
    
    // enumas, kuriame nurodoma, kad pradinis langas tures dvi busenas (segmentus): registravimosi ir prisijungimo
    enum Segment {
        case register, login
    }
    
    
    @IBOutlet private weak var userLoginSegmentedController: UISegmentedControl!
    
    @IBOutlet private weak var enterUsernameTextField: UITextField!
    
    @IBOutlet private weak var enterPasswordTextField: UITextField!
    
    @IBOutlet private weak var retypePasswordTextField: UITextField!
    
    @IBOutlet private weak var loginButton: UIButton!
    

    
    var currentSegment: Segment = .register
    let userManager = UserManager()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // textfieldu remeliu spalvos ir stroio keitimas:
        let myColor = UIColor.systemBlue
        enterUsernameTextField.layer.borderColor = myColor.cgColor
        enterPasswordTextField.layer.borderColor = myColor.cgColor
        retypePasswordTextField.layer.borderColor = myColor.cgColor
        
        enterUsernameTextField.layer.borderWidth = 2.0
        enterPasswordTextField.layer.borderWidth = 2.0
        retypePasswordTextField.layer.borderWidth = 2.0
        
        //textfield delegatai, bandymui dissmisinti klaviatura
        //        enterUsernameTextField.delegate = self
        //        enterPasswordTextField.delegate = self
        //        retypePasswordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    /* segmentinio kontrolerio veikimo f-ja. joje atsizvelgiant i pasirinkta busena (.login ar .register) parodoma ar bus isvedamas passwordo konfirminimo teksto laukas. Taip pat switcho pagalba, atsizvelgiant i segmenta, parenkamas rodomo labelio ant mygtuko uzrasas */
    @IBAction private func userLoginSegmentedControllerStateChanged(_ sender: Any) {
        
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
    
    /* mygtuko paspaudimas - atliekamos f-jos: priklausomai nuo pasirinkto segmento sukuriama initialResult konstanta, i kuria paduodami username, password (jei busena .register tai dar ir retypePassword) duomenys is atitinkamu textfieldu. initialResult duomenys toliau per konstanta userManager keliauja i atskirai esancia UserManager klase, kur aprasyta ivestu duomenu patikrinimo logika.
     */
    
    @IBAction private func loginButtonTapped(_ sender: Any) {
        
        //patikrinimas ar veikia duomenu ivedimas (nebutinas)
        print(enterUsernameTextField.text!)
        print(enterPasswordTextField.text!)
        
        switch currentSegment {
            
            // Kol kas neradau sprendimo kaip su if'u unwrappinti Optionals. Ismeta switch error'a:
            // if let username = username, let password = password, let retypePassword = retypePassword {
            
        case .register:
            let initialResult = userManager.register(username: enterUsernameTextField.text ?? "",
                                                     password: enterPasswordTextField.text ?? "",
                                                     retypePassword: retypePasswordTextField.text ?? "")
            checkUser(from: initialResult)
            
            
        case .login:
            let initialResult = userManager.login(username: enterUsernameTextField.text ?? "",
                                                  password: enterPasswordTextField.text ?? "")
            checkUser(from: initialResult)
            
        }
        
        
        
    }
    
    private func checkUser(from createdUser: CreatedUser) {
        if let errorTitle = createdUser.errorTitle,
           let mistakeDescription = createdUser.mistakeDescription {
            showError(title: errorTitle, message: mistakeDescription)
            print("el erroro")
        } else {
            if createdUser.user != nil {
                // navigation viewControleris ir perejimas i kita VC
                let transfersViewController = TransfersViewController()
                navigationController?.pushViewController(transfersViewController, animated: true)
                
                //bandymas perduoti duomenis i TransfersVC pasveikinimo lauka per passtxt kintamaji
                // MARK: reikes perdayrti su delegatu? o ir skaitosi kazkaip ne negraziai
                transfersViewController.passtxt = "Hello \(createdUser.user!.username!), money amount that you have: \(createdUser.user!.moneyAmount!)"
                print("OK")
            }
        }
        
    }
    /* Klaidos rodymo f-ja. Pirminiame variante CodeAcademyChat buvo naudojamas errorMessageLabel, kuris pakeistas UIAlertAction'u.
     TODO: perziureti ir pakeisti sita alerta, kad jis butu imamas is UIAlertController klases */
    
    private func showError(title: String, message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    
}







// extensionas, kad butu galima dissmissinti keyboard (1-as budas, su delegatais). Reikia i viewDIdLoad ikelti textfieldu delegatus

//extension UIViewController: UITextFieldDelegate {
//        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//            textField.resignFirstResponder()
//            return true
//        }
//    }


