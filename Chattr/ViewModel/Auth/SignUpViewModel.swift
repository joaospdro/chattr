//
//  SignUpViewModel.swift
//  Chattr
//
//  Created by Joao Pedro Oliveira on 23/07/22.
//

import Foundation

protocol AuthProtocol {
    var formIsValid: Bool { get }
}

struct SignUpViewModel: AuthProtocol {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
                && password?.isEmpty == false
                && fullname?.isEmpty == false
                && username?.isEmpty == false
    }
}
