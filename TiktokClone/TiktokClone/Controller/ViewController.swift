//
//  ViewController.swift
//  TiktokClone
//
//  Created by AHMET HAKAN YILDIRIM on 1.07.2023.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupView()
    }
    
    func setupView(){
        facebookButton.layer.cornerRadius = 17
        signUpButton.layer.cornerRadius = 17
        googleButton.layer.cornerRadius = 17
        loginButton.layer.cornerRadius = 17
    
    }
    @IBAction func signUpDidTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
        viewController.modalPresentationStyle = .fullScreen
    }
    
    @IBAction func signInDidTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
        viewController.modalPresentationStyle = .fullScreen
    }
    
}



