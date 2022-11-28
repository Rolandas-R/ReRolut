//
//  TransfersViewController.swift
//  ReRolut
//
//  Created by reromac on 2022-11-26.
//

import UIKit

class TransfersViewController: UIViewController {
    
    @IBOutlet weak var userGreetingAndInfoLabel: UILabel!
    
    @IBOutlet weak var enteringAmountTextField: UITextField!
    
    @IBOutlet weak var transferToUserTextField: UITextField!
    
    @IBOutlet weak var dollarLogo: UIImageView!
    
    @IBOutlet weak var personLogo: UIImageView!
    
    @IBOutlet weak var logOutButon: UIButton!
    
    var passtxt: String?
    
    let userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userGreetingAndInfoLabel.text = passtxt
        
        let myColor = UIColor.systemBlue
        enteringAmountTextField.layer.borderColor = myColor.cgColor
        transferToUserTextField.layer.borderColor = myColor.cgColor
        enteringAmountTextField.layer.borderWidth = 2.0
        transferToUserTextField.layer.borderWidth = 2.0
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction private func logOutButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction private func transferButtonTapped(_ sender: Any) {
        let transferUser = userManager.checkUsersList(username: transferToUserTextField.text ?? "")
        checkUser(from: transferUser)
//        let transferSum = userManager.
    }
        

    
    
    func checkUser(from transferUser: CreatedUser) {
        if let errorTitle = transferUser.errorTitle,
           let mistakeDescription = transferUser.mistakeDescription {
            showError(title: errorTitle, message: mistakeDescription)
            print("el erroro")
        } else {
            if transferUser.user != nil {
                print("OK")
            }
        }
    }
        /* Klaidos rodymo f-ja. Pirminiame variante CodeAcademyChat buvo naudojamas errorMessageLabel, kuris pakeistas UIAlertAction'u.
         TODO: perziureti ir pakeisti sita alerta, kad jis butu imamas is UIAlertController klases */
        
    func showError(title: String, message: String) {
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
        }
        
    }

    
    
    
    //    // 2 budas dissmisint keyboarda paspaudus return
    //    @IBAction func textFielEditingDone(_ sender: UITextField) {
    //        sender.resignFirstResponder()
    //    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    

