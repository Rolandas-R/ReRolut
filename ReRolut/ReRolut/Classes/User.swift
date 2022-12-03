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
    var moneyAmount: Int
    
    init(username: String, password: String, moneyAmount: Int) {
        self.username = username
        self.password = password
        self.moneyAmount = moneyAmount
    }
    
  
    // TODO: pervedimu ir tasku apskaitos funkcijos
    
    func sendMoney(amount: Int){
        self.moneyAmount -= amount
    }
    
    func receiveMoney(amount: Int){
        self.moneyAmount += amount
    }
    
    func userAmount(username: String) -> Int{
        return self.moneyAmount
    }

}


