//
//  AuthenticationViewModel.swift
//  Futag
//
//  Created by Furkan Erdoğan on 26.01.2022.
//

import Foundation
import UIKit


protocol FormViewModel {
    func updateForm()
}

protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
    var buttonBackgroundColor: UIColor {get}
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false 
        
    }
    
    var buttonBackgroundColor: UIColor {
         formIsValid ? .clubYellow : .clubYellow.withAlphaComponent(0.5)
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
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? .red : .clubYellow.withAlphaComponent(0.5)
    }
    
    
}

struct ResetPasswordViewModel: AuthenticationViewModel {
    var email: String?
    
    var formIsValid: Bool {return email?.isEmpty == false}
    
    var buttonBackgroundColor: UIColor {
         formIsValid ? .clubYellow : .clubYellow.withAlphaComponent(0.5)
    }
    
}
