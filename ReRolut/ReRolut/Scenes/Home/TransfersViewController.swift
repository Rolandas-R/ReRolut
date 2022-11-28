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
    
    var passtxt: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userGreetingAndInfoLabel.text = passtxt
        
        let myColor = UIColor.systemBlue
        enteringAmountTextField.layer.borderColor = myColor.cgColor
        transferToUserTextField.layer.borderColor = myColor.cgColor
        enteringAmountTextField.layer.borderWidth = 2.0
        transferToUserTextField.layer.borderWidth = 2.0
        
        self.navigationController?.navigationItem.hidesBackButton = true
        

        // Do any additional setup after loading the view.
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

}
