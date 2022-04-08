//
//  ImageUploader.swift
//  Futag
//
//  Created by Furkan Erdoğan on 26.01.2022.
//

import Foundation
import FirebaseStorage

import UIKit


struct ImageUploader {
    
    static func uploadImage(image: UIImage?, completion: @escaping(String) -> Void) {
        guard let imageData = image?.jpegData(compressionQuality: 0.75) else {return}
        
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/Images/\(fileName)")
        
        print("FileName: \(fileName)")
        
        UserDefaults.standard.set(fileName, forKey: "imageFileName")
        
        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Debug: failed to upload Image \(error.localizedDescription)")
                
                return
            }
            
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else {return}
                completion(imageUrl)
            }
        }
            
        
    }
}
