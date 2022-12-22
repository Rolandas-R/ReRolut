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
    

    var currentUser: User!
//    var transfer: Transfer!
//    let transferValidator = TransferValidator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userGreetingAndInfoLabel.text = "Hello \(currentUser.username), money amount that you have: \(currentUser.moneyAmount)"
        
        
        let myColor = UIColor.systemBlue
        enteringAmountTextField.layer.borderColor = myColor.cgColor
        transferToUserTextField.layer.borderColor = myColor.cgColor
        enteringAmountTextField.layer.borderWidth = 2.0
        transferToUserTextField.layer.borderWidth = 2.0
        
//        self.navigationController?.navigationItem.setHidesBackButton(true, animated:false)
        let rightButton = UIBarButtonItem(title: "Transfer History", style: .done, target: self, action: #selector(transferHistoryButtonTapped(_:)))
        
        self.navigationItem.rightBarButtonItems = [rightButton]
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        self.navigationController?.isNavigationBarHidden = false

    }
    
    
    // MARK: -- Actions:
    
    @IBAction private func logOutButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func transferButtonTapped(_ sender: Any) {
        
        let userToTransfer = UserManager.checkUsersList(
            username: transferToUserTextField.text ?? "")
        
        let moneyResult = TransferValidator.transferMoney(
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

    private func moneyTransfering(from currentUser: User, to receiver: User, amount: Int) {

            currentUser.sendMoney(amount: amount)
            receiver.receiveMoney(amount: amount)

            UIAlertController.showErrorAlert(title: "Transfer Complete", message: "Success! \n\(currentUser.username), you transfered \(amount) to \(receiver.username)", controller: self)
            userGreetingAndInfoLabel.text! = ("sender's \(currentUser.username) money amount left: \(currentUser.moneyAmount); \nreceiver's \(receiver.username) money amount is: \(receiver.moneyAmount)")


    }
    
//    func printTransactionHistory() {
//        var trasactionContent = [String]()
//
//        for transaction in transfer. {
//            let content = """
//            Sender: \(transfer.sender)
//
//            Receiver: \(transfer.receiver)
//
//            Amount: \(transfer.transferedAmount)
//            """
//
//            trasactionContent.append(content)
//
//        }
//        print(trasactionContent)
//
//
//    }

    @IBAction func transferHistoryButtonTapped(_ sender: UIBarButtonItem) {
        
        let result = TransferValidator.transfers
        
        for transfer in result {
            dump(transfer)
        }
//        printTransactionHistory()
        print("count: \(result.count)")

    }
    
    // keyboard dismissinimo f-ja
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


