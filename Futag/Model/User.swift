//
//  User.swift
//  Futag
//
//  Created by Furkan Erdoğan on 16.01.2022.
//

import Foundation
import Firebase

struct User {
    var name: String
    let email: String
    var surname: String
    var password: String
    var profileImage: URL?
    var profileImageName: URL?
    let userUid: String
    var birthday: String?
    let registrationTime: Date?
    
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == userUid }
    
    init(uid: String, dictionary: [String: Any]) {
        self.userUid = uid
        
        self.name = dictionary["name"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.surname = dictionary["surname"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
        self.birthday = dictionary["birthday"] as? String ?? ""
        self.registrationTime = dictionary["registrationTime"] as? Date 

        
        if let profileImageUrlString = dictionary["profileImage"] as? String {
            guard let url = URL(string: profileImageUrlString) else { return }
            self.profileImage = url
        }
    }
}

