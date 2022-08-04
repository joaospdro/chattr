//
//  SignInViewModel.swift
//  Chattr
//
//  Created by Joao Pedro Oliveira on 23/07/22.
//

import Foundation

struct SignInViewModel: AuthProtocol {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
}
