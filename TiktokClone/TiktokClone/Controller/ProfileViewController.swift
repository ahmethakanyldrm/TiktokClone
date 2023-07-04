//
//  ProfileViewController.swift
//  TiktokClone
//
//  Created by AHMET HAKAN YILDIRIM on 4.07.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func logoutAction(_ sender: UIBarButtonItem) {
        LogoutService.logoutApi.logout()
    }
    
}
