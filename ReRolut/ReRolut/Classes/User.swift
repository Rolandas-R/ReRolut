//
//  User.swift
//  ReRolut
//
//  Created by reromac on 2022-11-26.
//

import Foundation

class User{
    let username: String
    let password: String
    var moneyAmount: Double
    
    init(username: String, password: String, moneyAmount: Double) {
        self.username = username
        self.password = password
        self.moneyAmount = moneyAmount
    }
    
    
    
    // TODO: pervedimu ir tasku apskaitos funkcijos
    private func recalculateMoneyAmount() -> Double {
        return 0.00
    }
    
    private func moneyTransfer(){}
    
    
    private func finalAmount() {
    }
}


