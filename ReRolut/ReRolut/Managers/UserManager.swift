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
    var initialAmount: Int = 100
    
    
    
    // vartotojo registravimo f- ja. grazina CreatedUser struct'a
    func register(username: String, password: String) -> CreatedUser {
        let registerErrorTitle = "Error in user creation process"
        
        // guardas padeda patikrinti ar ivestas slaptazodis ir passwordas i tekstini lauka,
        // tikrinimo logika: jei kazkas neivesta ar nesutampa - useris nesukuriamas ir isvedamas klaidos pranesimas
        guard !username.isEmpty, !password.isEmpty
                
        else {
            return CreatedUser(user: nil, errorTitle: registerErrorTitle, mistakeDescription: "Fill username and/or password")
        }
        
        // antras guardas, kurio pagalba uztikriname kad username ir passwordas turetu bent 8 simbolius:

        guard username.count > 7, password.count > 7
                
        else {
            return CreatedUser(user: nil, errorTitle: registerErrorTitle, mistakeDescription: "Username and/or password must be at least 8 characters long")
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
        
        // pasitikrinimas sau - isvedami visi arejuje users esantys useriai
        // dump(users)
        
        // perduodama CreatedUser structui
        return CreatedUser(user: user, errorTitle: registerErrorTitle, mistakeDescription: nil)
    }
    
    
    
    // vartotojo loginimo f-ja kur tikrinama ar toks vartotojas yra ir ar pateikti visi duomenys sutampa
    // tikrinimas su closure
    func login(username: String, password: String) -> CreatedUser {
        let loginErrorTitle = "Error while loging in"
        /*
         // vienas is variantu su closure:
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
        
        // jei po auksciau atliktu patikrinimu viskas tvarkoje grazinamas CreatedUser
        return CreatedUser(user: user, errorTitle: loginErrorTitle, mistakeDescription: nil)
    }
    
    // Funkcija, kuri paziuri ar tarp useriu yra toks, kuris ieskomas
    func checkUsersList(username: String) -> CreatedUser {
        let userCheckingErrorTitle = "Error with user validation"
        
        guard !username.isEmpty
        else {
            return CreatedUser(user: nil, errorTitle: userCheckingErrorTitle, mistakeDescription: "Fill the user you want to transfer")
        }
        
        guard let user = users.first(where: { $0.username == username })
        else {
            return CreatedUser(user: nil, errorTitle: userCheckingErrorTitle, mistakeDescription: "No such user with this username")
        }
        return CreatedUser(user: user, errorTitle: userCheckingErrorTitle, mistakeDescription: nil)
    }
}
        





//
// MARK: zemiau esantis guardas neveikia, praleidzia minusines reiksmes - reikes perdaryti!
//        guard let user = users.first(where: { user in
//            user.username == username })
//        else {
//            return CreatedUser(user: nil, errorTitle: amountValidationErrorTitle, mistakeDescription: "You don't have such amount to transfer")
//        }
 
    



    
    
    

