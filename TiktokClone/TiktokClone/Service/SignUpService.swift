//
//  SignUpService.swift
//  TiktokClone
//
//  Created by AHMET HAKAN YILDIRIM on 3.07.2023.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import ProgressHUD

struct SignUpService {
    static var signUpApi = SignUpServiceApi()
}

class SignUpServiceApi {
    func signUp(withUsername username: String, email: String, password: String ,image: UIImage?, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard let imageSelected = image else {
            print("Avatar is nil")
            ProgressHUD.showError("Please enter a Profile Image")
            return
        }
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else { return }

        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            if let authData = authDataResult {
                print(authData.user.email)
                var dict: Dictionary<String, Any> = [
                    UID: authData.user.uid,
                    EMAIL: authData.user.email,
                    USERNAME: username,
                    PROFILE_IMAGE_URL: "",
                    STATUS: "",
                ]
                let storageRef = Storage.storage().reference(forURL: "gs://tiktokclone-c14a1.appspot.com")
        
                let storageProfileRef = Reference().storageSpecificImages(uid: authData.user.uid)
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpg"
                StorageService.savePhoto(username: username, uid: authData.user.uid, data: imageData, metaData: metadata, storageProfileRef: storageProfileRef, dict: dict) {
                    onSuccess()
                } onError: { errorMessage in
                    onError(errorMessage)
                }


            }
            
        }
    }
}
