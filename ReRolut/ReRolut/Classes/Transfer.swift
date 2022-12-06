//
//  Transfer.swift
//  ReRolut
//
//  Created by reromac on 2022-12-06.
//

import Foundation

class Transfer {
   
    let sender: String!
    let receiver: String!
    var moneyAmount: Int!
    
    init(sender: String!, receiver: String!, moneyAmount: Int!) {
        self.sender = sender
        self.receiver = receiver
        self.moneyAmount = moneyAmount
    }

    
    var transfers: [Transfer] = []
    
    func transferHistorija(sender: String!, receiver: String!, amount: Int!) {
        
        let history = Transfer(sender: sender, receiver: receiver, moneyAmount: amount)
        transfers.append(history)
        dump(transfers)
        
    }
    
}
