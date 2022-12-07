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
    
    static let instance = TransferValidator()

    
    var transfers: [Transfer] = []
    
    
    func transferMoney(sender: String, receiver: String, amount: Int) -> ValidatedTransfer {
        let errorTitle = "Error in Transfer Validation"
        
        // ar netusti laukai
        guard !sender.isEmpty, !receiver.isEmpty else {
            return ValidatedTransfer(amount: nil, errorTitle: errorTitle, errorMessage: "Empty fields")
        }
        // ar nesiuncia sau ir ar yra toks gavejas
        
        guard sender != receiver else {
            return ValidatedTransfer(amount: nil, errorTitle: errorTitle, errorMessage: "You cant' transfer to yourself")
        }
            
        // ar suma yra teigiama
        guard amount > 0 else {
            return ValidatedTransfer(amount: nil, errorTitle: errorTitle, errorMessage: "You can not transfer Zero or less")
        }
        
        // ar useris turi tiek kiek nori pervesti
        let user = UserManager.instance.users.first(where: { $0.username == sender })
        if (user?.moneyAmount)! < amount {
            return ValidatedTransfer(amount: nil, errorTitle: errorTitle, errorMessage: "You don't have enough money")
        }
        
        let transfer = Transfer(sender: sender, receiver: receiver, transferedAmount: amount)
        
        transfers.append(transfer)
//        dump(transfers)
        
        return ValidatedTransfer(amount: amount, errorTitle: "", errorMessage: nil)
    }
  
    
}
 
