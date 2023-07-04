//
//  Reference.swift
//  TiktokClone
//
//  Created by AHMET HAKAN YILDIRIM on 3.07.2023.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

let REF_USER = "users"
let URL_STORAGE_ROOT = "gs://tiktokclone-c14a1.appspot.com"
let STORAGE_PROFILE = "profile"
let EMAIL = "email"
let UID = "uid"
let USERNAME = "username"
let PROFILE_IMAGE_URL = "profileImageUrl"
let STATUS = "status"
let IDENTIFIER_TABBAR = "TabbarVC"
let IDENTIFIER_MAIN = "MainVC"

class Reference {
    let databaseRoot = Database.database().reference()
    
    var databaseUsers: DatabaseReference {
        return databaseRoot.child(REF_USER)
    }
    
    let storageRoot = Storage.storage().reference(forURL: URL_STORAGE_ROOT)
    
    var storageProfile: StorageReference {
        return storageRoot.child(STORAGE_PROFILE)
    }
    
    func databaseSpesificUser(uid: String) -> DatabaseReference {
        return databaseUsers.child(uid)
    }
    
    func storageSpecificImages(uid: String) -> StorageReference  {
        return storageProfile.child(uid)
    
    }
    
    
}
