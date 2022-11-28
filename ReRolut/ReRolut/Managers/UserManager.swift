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
    var initialAmount: Double = 100.0
    
    
    // vartotojo registravimo f- ja. grazina CreatedUser struct'a
    func register(username: String, password: String, retypePassword: String) -> CreatedUser {
        let registerErrorTitle = "Error in user creation process"
        
        // guardas padeda patikrinti ar ivestas slaptazodis ir passwordas i tekstini lauka,
        // tikrinimo logika: jei kazkas neivesta ar nesutampa - useris nesukuriamas ir isvedamas klaidos pranesimas
        guard !username.isEmpty, !password.isEmpty
                
        else {
            return CreatedUser(user: nil, errorTitle: registerErrorTitle, mistakeDescription: "Fill username and/or password")
        }
        
        // antras guardas, kurio pagalba uztikriname kad username ir passwordas turetu bent 8 simbolius:
//            MARK: @warning reikes 2 pakeisti i 7
        guard username.count > 2, password.count > 2
                
        else {
            return CreatedUser(user: nil, errorTitle: registerErrorTitle, mistakeDescription: "Username and/or password must be at least 8 characters long")
        }
        
        //patikrinimas ar registruojantis passwordo pakartojimas sutampa su passwordu
        if password != retypePassword {
            return CreatedUser(user: nil, errorTitle: registerErrorTitle, mistakeDescription: "Your password didn't match")
        }
        
        // pereinama ir patikrinamas useriu sarasas
        for user in users {
            if username == user.username {
                return CreatedUser(user: nil, errorTitle: registerErrorTitle, mistakeDescription: "User with same username already exists")
            }
        }
        
        // jei viskas tvarkoje sukuriamas naujas objektas user ir pridedamas prie users array'iaus
        let user = User(username: username, password: password, moneyAmount: initialAmount)
        
        users.append(user)
        dump(users)
        
        // perduodama CreatedUser structui
        return CreatedUser(user: user, errorTitle: registerErrorTitle, mistakeDescription: nil)
    }
    
    // vartotojo loginimo f-ja kur tikrinama ar toks vartotojas yra ir ar pateikti visi duomenys sutampa
    // tikrinimas su closure
    func login(username: String, password: String) -> CreatedUser {
        let loginErrorTitle = "Error while loging in"
        /*
         //vienas is variantu su closure:
         let checkedUser = users.first { user in
         user.username == username }
         //MARK: cia panaudotas antras CLOSURE variantas is CodeAcademyChat */
        let checkedUser = users.first(where: { $0.username == username })
        
        // sitas guardas patikrina ir toliau praleidzia (arba ne), atsizvelgiant ar sutampa pateikti userio duomenys
        guard let user = checkedUser
        else {
            return CreatedUser(user: nil, errorTitle: loginErrorTitle, mistakeDescription: "No such user with this username")
        }
        
        if user.password != password {
            return CreatedUser(user: nil, errorTitle: loginErrorTitle, mistakeDescription: "Wrong password")
        }
        
        //jei po auksciau atliktu patikrinimu viskas tvarkoje grazinamas CreatedUser
        return CreatedUser(user: user, errorTitle: loginErrorTitle, mistakeDescription: nil)
    }
    
    
    func checkUsersList(username: String) -> CreatedUser {
        let userCheckingErrorTitle = "Error with user validation"
        
        for user in users where username != user.username {
            return CreatedUser(user: user, errorTitle: userCheckingErrorTitle, mistakeDescription: "No such user with this username")
        }
        let user = User(username: username, password: "", moneyAmount: 0.0 )
        return CreatedUser(user: user, errorTitle: userCheckingErrorTitle, mistakeDescription: nil)
        
    }
        
}

