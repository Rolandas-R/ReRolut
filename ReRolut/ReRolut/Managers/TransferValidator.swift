//
//  TransferValidator.swift
//  ReRolut
//
//  Created by reromac on 2022-12-06.
//

import Foundation

struct ValidatedTransfer{
    
    let amount: Int?
    let errorTitle: String?
    let errorMessage: String?
}

class TransferValidator {
    
    let sender: String? = ""
    let receiver: String? = ""
    var moneyAmount: Int?
    
    
    func transferMoney(sender: String, receiver: String, amount: Int) -> ValidatedTransfer {
        let errorTitle = "Error in Transfer Validation"
        
        // ar netusti laukai
        guard !sender.isEmpty, !receiver.isEmpty else {
            return ValidatedTransfer(amount: nil, errorTitle: errorTitle, errorMessage: "Empty fields")
        }
        // ar nesiuncia sau ir ar yra toks gavejas
        for user in UserManager.instance.users{
            if sender == user.username {
                return ValidatedTransfer(amount: nil, errorTitle: errorTitle, errorMessage: "You cant' transfer to yourself")
            } else if receiver == user.username{
                return ValidatedTransfer(amount: nil, errorTitle: errorTitle, errorMessage: "There is nos such receiver")
            }
        }
        
        // ar suma yra teigiama
        guard amount >= 0 else {
            return ValidatedTransfer(amount: nil, errorTitle: errorTitle, errorMessage: "You can not transfer Zero or less")
        }
        
        // ar useris turi tiek kiek nori pervesti
        let user = UserManager.instance.users.first(where: { $0.username == sender })
        if (user?.moneyAmount)! < amount {
            return ValidatedTransfer(amount: nil, errorTitle: errorTitle, errorMessage: "You don't have enough money")
        }
        
        return ValidatedTransfer(amount: amount, errorTitle: errorTitle, errorMessage: nil)
    }
        
        
        
    }
 
