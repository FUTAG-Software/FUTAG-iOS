//
//  UserService.swift
//  Futag
//
//  Created by Furkan Erdoğan on 9.01.2022.
//


import Firebase
import UIKit

typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)



struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            
            guard let dic = snapshot?.data() else {return}
            
            let user = User(uid: uid, dictionary: dic)
            
            completion(user)
        }
    }
}

