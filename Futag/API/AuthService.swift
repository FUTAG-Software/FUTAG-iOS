//
//  AuthService.swift
//  Futag
//
//  Created by Furkan Erdoğan on 9.01.2022.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let name: String
    let surname: String
    let profileImage: UIImage?
    let birthday: String
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(withCredential credentials: AuthCredentials, completion: @escaping(Error?) -> Void) {
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                
                if let error = error {
                    print("DEBUG: Error is \(error.localizedDescription)")
                    return
                }
                

                guard let uid = result?.user.uid else { return }
                let fileName = UserDefaults.standard.string(forKey: "imageFileName")

                let values = ["email": credentials.email,
                              "name": credentials.name,
                              "surname": credentials.surname,
                              "profileImage": imageUrl,
                              "profileImageName": fileName ?? "",
                              "birthday": credentials.birthday,
                              "registrationTime": Date(),
                              "userUid": uid
                ] as [String : Any]
                
                COLLECTION_USERS.document(uid).setData(values, completion: completion)
                
            }
        }
    }
}


