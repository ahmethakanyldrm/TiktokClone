//
//  SignInService.swift
//  TiktokClone
//
//  Created by AHMET HAKAN YILDIRIM on 3.07.2023.
//


import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import ProgressHUD

struct SignInService {
    static var signInApi = SignInServiceApi()
}

class SignInServiceApi {
    func signIn(email:String, password:String, onSuccess: @escaping() -> Void, onError:@escaping(_ errorMessage:String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authData, error in
            if let error = error {
                onError(error.localizedDescription)
            }
            onSuccess()
        }
    }
}

