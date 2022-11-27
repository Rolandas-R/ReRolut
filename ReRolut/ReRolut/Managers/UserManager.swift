//
//  UserManager.swift
//  ReRolut
//
//  Created by reromac on 2022-11-26.
//

import Foundation

struct CreatedUser {
    let user: User?
    let errorTitle: String?
    let mistakeDescription: String?
}

class UserManager {
    
    var users: [User] = []


// vartotojo registravimo f- ja. grazina UserResult struct'a
    func register(username: String, password: String, retypePassword: String) -> CreatedUser {
        let registerErrorTitle = "Error in user creation process"
        
        // guardas padeda patikrinti ar ivestas slaptazodis ir passwordas i tekstini lauka
        guard !username.isEmpty, !password.isEmpty
        // tikrinimo logika: jei kazkas neivesta ar nesutampa - useris nesukuriamas ir isvedamas klaidos pranesimas
        else {
            return CreatedUser(user: nil, errorTitle: registerErrorTitle, mistakeDescription: "Fill username and/or password")
        }
        if password != retypePassword {
            return CreatedUser(user: nil, errorTitle: registerErrorTitle, mistakeDescription: "Your password didn't match")
        }
        
        // pereinama ir patikrinamas userListas
        for user in users {
            if username == user.username {
                return CreatedUser(user: nil, errorTitle: registerErrorTitle, mistakeDescription: "User with same username already exists")
            }
        }
        
        // jei viskas tvarkoje sukuriamas naujas objektas user ir pridedamas prie userListo
        let user = User(username: username, password: password, moneyAmount: 100.0)
        
        users.append(user)
        // perduodama UserResult structui
        return CreatedUser(user: user, errorTitle: registerErrorTitle, mistakeDescription: nil)
    }
    
// vartotojo loginimo f-ja kur tikrinama ar toks vartotojas yra ir ar pateikti visi duomenys sutampa
// tikrinimas su closure
    func login(username: String, password: String) -> CreatedUser {
        let loginErrorTitle = "Error while loging in"
        /*
         //vienas is variantu su closure:
         let userOptional = userList.first { user in
                     user.username == username
                 }
         // dar variantas kaip paduodam funkcija vietoj closure:
        //        let userOptional = userList.first(where: arPetras)
         
         //MARK: cia panaudotas antras variantas (CLOSURE) */
        let checkedUser = users.first(where: { $0.username == username })

        // guardas patikrina ir toliau praleidzia (arba ne), atsizvelgiant ar sutampa pateikti userio duomenys
        guard let user = checkedUser else {
            return CreatedUser(user: nil, errorTitle: loginErrorTitle, mistakeDescription: "No such user with this username")
        }
        
        if user.password != password {
            return CreatedUser(user: nil, errorTitle: loginErrorTitle, mistakeDescription: "Wrong password")
        }
        return CreatedUser(user: user, errorTitle: loginErrorTitle, mistakeDescription: nil)
    }
    
}

