//
//  Constants.swift
//  Futag
//
//  Created by Furkan Erdoğan on 9.01.2022.
//

import Foundation

import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("images")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
