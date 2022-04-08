//
//  AuthService.swift
//  Futag
//
//  Created by Furkan Erdoğan on 9.01.2022.
//

import UIKit
import Firebase
import FirebaseFirestore

struct AuthCredentials {
    let email: String
    let password: String
    let name: String
    let surname: String
    let profileImage: UIImage?
    let birthday: String?
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
                              "birthday": credentials.birthday ?? "",
                              "registrationTime": Date(),
                              "userUid": uid
                ] as [String : Any]
                
                COLLECTION_USERS.document(uid).setData(values, completion: completion)
                
            }
        }
    }
    
    


    
    
    static func resetPassword(withEmail email: String, completion: SendPasswordResetCallback?) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
    
    func updateProfileImage(image: UIImage, completion: @escaping(URL?) -> Void) {
           guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
           guard let uid = Auth.auth().currentUser?.uid else { return }
           let filename = NSUUID().uuidString
           let ref = Storage.storage().reference(withPath: "/Images/\(filename)")
        
        print("Kullanıcı\(uid)")
           
           ref.putData(imageData, metadata: nil) { (meta, error) in
               ref.downloadURL { (url, error) in
                   guard let profileImageUrl = url?.absoluteString else { return }
                   let values = ["profileImage": profileImageUrl,
                                 "profileImageName": filename]
                   
                   COLLECTION_USERS.document(uid).updateData(values) { err in
                       completion(url)
                   }
               }
           }
       }
    
}




