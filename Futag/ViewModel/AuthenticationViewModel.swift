//
//  AuthenticationViewModel.swift
//  Futag
//
//  Created by Furkan Erdoğan on 26.01.2022.
//

import Foundation

protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}

struct RegistrationViewModel: AuthenticationViewModel {
    var name: String?
    var surname: String?
    var email: String?
    var password: String?
    var birthday: String?
    
    var formIsValid: Bool {
        
        return email?.isEmpty == false && password?.isEmpty == false && name?.isEmpty == false && surname?.isEmpty == false && birthday?.isEmpty == false
        
    }
    
    
    
}
