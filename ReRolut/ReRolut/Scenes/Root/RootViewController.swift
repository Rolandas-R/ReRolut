//
//  RootViewController.swift
//  ReRolut
//
//  Created by reromac on 2022-11-25.
//



import UIKit

class RootViewController: UIViewController {
    
    // enumas, kuriame nurodoma, kad pradinis langas tures dvi busenas (segmentus): registravimosi ir prisijungimo
    enum Segment {
        case register, login
    }
    
    // MARK: -- Outlets:
    
    @IBOutlet private weak var userLoginSegmentedController: UISegmentedControl!
    
    @IBOutlet private weak var enterUsernameTextField: UITextField!
    
    @IBOutlet private weak var enterPasswordTextField: UITextField!
    
    @IBOutlet private weak var loginButton: UIButton!
    

    var currentSegment: Segment = .register

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // segmentedController raidziu spalvos keitimas is juodos i balta ir melyna
        userLoginSegmentedController.setTitleColor(UIColor.white)

        // textfieldu remeliu spalvos ir storio keitimas
        let myColor = UIColor.systemBlue
        enterUsernameTextField.layer.borderColor = myColor.cgColor
        enterPasswordTextField.layer.borderColor = myColor.cgColor
        
        enterUsernameTextField.layer.borderWidth = 2.0
        enterPasswordTextField.layer.borderWidth = 2.0

    }
    
    
    // MARK: -- Actions:
    
    /* segmentinio kontrolerio veikimo f-ja. joje atsizvelgiant i pasirinkta busena (.login ar .register) parenkamas rodomo labelio ant mygtuko uzrasas */
    @IBAction private func userLoginSegmentedControllerStateChanged(_ sender: Any) {
        
        if userLoginSegmentedController.selectedSegmentIndex == 0 {
            currentSegment = .register
        } else if userLoginSegmentedController.selectedSegmentIndex == 1 {
            currentSegment = .login
        }
               
        // switchas kurio pagalba isvedamas uzrasas ant mygtuko:
        switch currentSegment {
        case .register:
            loginButton.setTitle("REGISTER", for: .normal)
        case .login:
            loginButton.setTitle("LOGIN", for: .normal)
        }
        
    }
    
    /* mygtuko paspaudimas - atliekamos f-jos: priklausomai nuo pasirinkto segmento sukuriama initialResult konstanta, i kuria paduodami username, password duomenys is atitinkamu textfieldu. initialResult duomenys toliau keliauja i UserManager klase, kur atitinkamose f-jose aprasyta ivestu duomenu patikrinimo logika.
     */
    
    @IBAction private func loginButtonTapped(_ sender: Any) {

        switch currentSegment {
            
        case .register:
            let initialResult = UserManager.instance.register(username: enterUsernameTextField.text ?? "",
                                                     password: enterPasswordTextField.text ?? "")
            checkUser(from: initialResult)
            
        case .login:
            let initialResult = UserManager.instance.login(username: enterUsernameTextField.text ?? "",
                                                  password: enterPasswordTextField.text ?? "")
            checkUser(from: initialResult)
        }
    }
    
    private func checkUser(from createdUser: CreatedUser) {
        if let errorTitle = createdUser.errorTitle,
           let mistakeDescription = createdUser.mistakeDescription {
            UIAlertController.showErrorAlert(title: errorTitle, message: mistakeDescription, controller: self)
        } else {
            if createdUser.user != nil {
                // navigation viewControleris ir perejimas i kita VC
                let transfersViewController = TransfersViewController()
                transfersViewController.currentUser = createdUser.user
                transfersViewController.passtxt = "Hello \(createdUser.user!.username), money amount that you have: \(createdUser.user!.moneyAmount)"
    
                navigationController?.pushViewController(transfersViewController, animated: true)
            }
        }
    }
    
    // keyboard dismiss'inimas
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// extensionas segmentedContollerio su raidziu spalvos keitimo funkcija (stackOverflow :))

extension UISegmentedControl {

    func setTitleColor(_ color: UIColor, state: UIControl.State = .normal) {
        var attributes = self.titleTextAttributes(for: .selected) ?? [:]
        var attributes2 = self.titleTextAttributes(for: .normal) ?? [:]
        attributes[.foregroundColor] = UIColor.white
        attributes2[.foregroundColor] = UIColor.systemBlue
        self.setTitleTextAttributes(attributes, for: .selected)
        self.setTitleTextAttributes(attributes2, for: .normal)
    }

}












