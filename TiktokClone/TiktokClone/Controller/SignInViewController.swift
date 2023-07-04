//
//  SignInViewController.swift
//  TiktokClone
//
//  Created by AHMET HAKAN YILDIRIM on 2.07.2023.
//

import ProgressHUD
import UIKit

class SignInViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet var signInButton: UIButton!

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordContainer: UIView!

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var emailContainer: UIView!

    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupEmailTextfield()
        setupPasswordTextfield()
        setupView()
    }

    // MARK: - Actions

    @IBAction func signInDidTapped(_ sender: UIButton) {
        view.endEditing(true)
        validateFields()
        signIn {
            let scene = UIApplication.shared.connectedScenes.first
            if let sd: SceneDelegate = (scene?.delegate as? SceneDelegate) {
                sd.configureInitialViewController()
            }
        } onError: { errorMessage in
            ProgressHUD.showError(errorMessage)
        }
    }
}

// MARK: - Setup

extension SignInViewController {
    func setupNavigationBar() {
        navigationItem.title = "Sign In"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupEmailTextfield() {
        emailContainer.layer.borderWidth = 1
        emailContainer.layer.borderColor = CGColor(red: 217 / 255, green: 217 / 255, blue: 217 / 255, alpha: 0.8)
        emailContainer.layer.cornerRadius = 20
        emailContainer.clipsToBounds = true
        emailTextField.borderStyle = .none
    }

    func setupPasswordTextfield() {
        passwordContainer.layer.borderWidth = 1
        passwordContainer.layer.borderColor = CGColor(red: 217 / 255, green: 217 / 255, blue: 217 / 255, alpha: 0.8)
        passwordContainer.layer.cornerRadius = 20
        passwordContainer.clipsToBounds = true
        passwordTextField.borderStyle = .none
    }

    func setupView() {
        signInButton.layer.cornerRadius = 35 / 2
        signInButton.clipsToBounds = true
        

    }

    private func signIn(onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String) -> Void) {
        ProgressHUD.show("Loading...")
        SignInService.signInApi.signIn(email: emailTextField.text!, password: passwordTextField.text!) {
            ProgressHUD.dismiss()
            onSuccess()
        } onError: { errorMessage in
            onError(errorMessage)
        }
    }
    
    private func validateFields() {
       
        guard let email = emailTextField.text, !email.isEmpty else {
            // print("Please enter a email")
            ProgressHUD.showError("Please enter a email")
            return
        }

        guard let password = passwordTextField.text, !password.isEmpty else {
            // print("Please enter a password")
            ProgressHUD.showError("Please enter a password")
            return
        }
    }
}
