//
//  User.swift
//  ReRolut
//
//  Created by reromac on 2022-11-26.
//

import Foundation

class User{
    let username: String!
    let password: String!
    var moneyAmount: Double?
    
    init(username: String, password: String, moneyAmount: Double) {
        self.username = username
        self.password = password
        self.moneyAmount = moneyAmount
    }
    
}
