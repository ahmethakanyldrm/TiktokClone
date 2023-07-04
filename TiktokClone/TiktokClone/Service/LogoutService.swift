//
//  LogoutService.swift
//  TiktokClone
//
//  Created by AHMET HAKAN YILDIRIM on 4.07.2023.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import ProgressHUD

struct LogoutService {
    static var logoutApi = LogoutServiceApi()
}

class LogoutServiceApi {
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch  {
            ProgressHUD.showError(error.localizedDescription)
            return
        }
        
        let scene = UIApplication.shared.connectedScenes.first
        if let sd: SceneDelegate = (scene?.delegate as? SceneDelegate) {
            sd.configureInitialViewController()
        }
    }
}
