//
//  TransfersViewController.swift
//  ReRolut
//
//  Created by reromac on 2022-11-26.
//

import UIKit

class TransfersViewController: UIViewController {
    
    // MARK: -- Outlets:
    
    @IBOutlet weak var userGreetingAndInfoLabel: UILabel!
    
    @IBOutlet weak var enteringAmountTextField: UITextField!
    
    @IBOutlet weak var transferToUserTextField: UITextField!
    
    
    

    var passtxt: String?

    var currentUser: User!
    
    let transferValidator = TransferValidator()
    
    

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
    
    
    // MARK: -- Actions:
    
    @IBAction private func logOutButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func transferButtonTapped(_ sender: Any) {
       
        let result = transferValidator.transferMoney(
            sender: currentUser.username,
            receiver: transferToUserTextField.text ?? "",
            amount: Int(enteringAmountTextField.text!) ?? 0 )
        
        checkUser(from: result)
    }
     
// funkcija patikrina ar toks useris kuriam bus pervedama egzistuoja
    private func checkUser(from result: ValidatedTransfer) {
      
        let receiver = transferToUserTextField.text ?? ""
        let transferAmount = Int(enteringAmountTextField.text!) ?? 0
        
 
        
        if let errorTitle = result.errorTitle,
           let errorMessage = result.errorMessage {
            UIAlertController.showErrorAlert(title: errorTitle, message: errorMessage, controller: self)
        } else {
            
       /* kai is UserManager klases gaunamas useris, showErrorAlert'as nerodomas ir paleidziama moneyTransfering funkcija */
            if result.amount != nil {
                moneyTransfering(from: currentUser, to: receiver, amount: transferAmount)
            }
        }
    }


/* moneyTransfering funkcija, kurios pagalba:
    1. pagal likusias salygas validuojami i textFiled'us ivesti duomenys:
        - ar laukai nera tusti;
        - ar nebandoma pervesti sau;
        - ar pervedama suma nera 0 (nulis) ir maziau, taip pat ar ji nevirsija siuntejo turima pinigu suma.
        Jei duomenys netenkina salygu - rodomas alertas su informacija.
    2. jei visos salygos tenkinamos, textfielde nurodytam useriui pervedamas nurodyta suma.
    3. po pervedimo, isvedama informacija showErrorAlert'e currentUseriui, kad jo nurodyta suma pervesta nurodytam useriui. Taip pat textLabelyje atvaizduojama tiek siuntejo (currentUser), tiek ir gavejo turimi pinigai (moneyAmount) po operacijos.
 */
    private func moneyTransfering(from currentUser: User, to receiver: String, amount: Int){
        let receiver = transferToUserTextField.text ?? ""
//
//        // 1. tikrinimas
//        if enteringAmountTextField.text == "" {
//            UIAlertController.showErrorAlert(title: "Transfer Error", message: "Enter amount to transfer", controller: self)
//
//        } else if userToTransfer == currentUser.username {
//            UIAlertController.showErrorAlert(title: "Transfer Error", message: "You can't transfer to yourself", controller: self)
//            return
//
//        } else if amount <= 0 || amount > currentUser.moneyAmount {
//            UIAlertController.showErrorAlert(title: "Transfer Error", message: "You can't transfer 0 or less, \nor amount that exeeds what you have", controller: self)
//            return
//        }
//        //2. pervedimo f-jos
        for user in UserManager.instance.users where receiver == user.username {
            currentUser.sendMoney(amount: amount)
            user.receiveMoney(amount: amount)
            //3. informavimas
            UIAlertController.showErrorAlert(title: "Transfer Complete", message: "Success! \n\(currentUser.username), you transfered \(amount) to \(user.username)", controller: self)
            userGreetingAndInfoLabel.text! = ("sender's \(currentUser.username) money amount left: \(currentUser.moneyAmount); \nreceiver's \(user.username) money amount is: \(user.moneyAmount)")
        }
        
    }
    
    
    // keyboard dismissinimo f-ja
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
    





