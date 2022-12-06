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

    }
    
    
    // MARK: -- Actions:
    
    @IBAction private func logOutButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func transferButtonTapped(_ sender: Any) {
        
        let userToTransfer = UserManager.instance.checkUsersList(
            username: transferToUserTextField.text ?? "")
        
        let moneyResult = transferValidator.transferMoney(
            sender: currentUser.username,
            receiver: transferToUserTextField.text ?? "",
            amount: Int(enteringAmountTextField.text!) ?? 0 )
        checkUser(from: userToTransfer, from: moneyResult)
    }
    
    // funkcija patikrina ar toks useris kuriam bus pervedama egzistuoja
    private func checkUser(from validatedUser: CreatedUser, from validatedAmount: ValidatedTransfer) {
        
        if let errorTitle = validatedUser.errorTitle,
           let errorMessage = validatedUser.mistakeDescription {
            UIAlertController.showErrorAlert(title: errorTitle, message: errorMessage, controller: self)
        }
    else if let errorTitle = validatedAmount.errorTitle,
            let errorMessage = validatedAmount.errorMessage {
            UIAlertController.showErrorAlert(title: errorTitle, message: errorMessage, controller: self)
            
        } else if validatedUser.user != nil
             && validatedAmount.amount != nil {
            moneyTransfering(from: currentUser, to: validatedUser.user!, amount: validatedAmount.amount!)
        }
    }

    private func moneyTransfering(from currentUser: User, to receiver: User, amount: Int){
        
        let receiver = transferToUserTextField.text ?? ""

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


