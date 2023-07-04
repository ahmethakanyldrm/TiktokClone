//
//  SignUpViewController.swift
//  TiktokClone
//
//  Created by AHMET HAKAN YILDIRIM on 1.07.2023.
//

import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import PhotosUI
import ProgressHUD
import UIKit

class SignUpViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet var avatar: UIImageView!

    @IBOutlet var signUpButton: UIButton!

    @IBOutlet var usernameContainer: UIView!
    @IBOutlet var usernameTextField: UITextField!

    @IBOutlet var emailContainer: UIView!
    @IBOutlet var emailTextField: UITextField!

    @IBOutlet var passwordContainer: UIView!
    @IBOutlet var passwordTextField: UITextField!

    var image: UIImage?

    // MARK: - LifeCycles

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUsernameTextfield()
        setupEmailTextfield()
        setupPasswordTextfield()
        setupView()
    }

    // MARK: - Setup

    private func setupNavigationBar() {
        navigationItem.title = "Create new account"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupUsernameTextfield() {
        usernameContainer.layer.borderWidth = 1
        usernameContainer.layer.borderColor = CGColor(red: 217 / 255, green: 217 / 255, blue: 217 / 255, alpha: 0.8)
        usernameContainer.layer.cornerRadius = 20
        usernameContainer.clipsToBounds = true
        usernameTextField.borderStyle = .none
    }

    private func setupEmailTextfield() {
        emailContainer.layer.borderWidth = 1
        emailContainer.layer.borderColor = CGColor(red: 217 / 255, green: 217 / 255, blue: 217 / 255, alpha: 0.8)
        emailContainer.layer.cornerRadius = 20
        emailContainer.clipsToBounds = true
        emailTextField.borderStyle = .none
    }

    private func setupPasswordTextfield() {
        passwordContainer.layer.borderWidth = 1
        passwordContainer.layer.borderColor = CGColor(red: 217 / 255, green: 217 / 255, blue: 217 / 255, alpha: 0.8)
        passwordContainer.layer.cornerRadius = 20
        passwordContainer.clipsToBounds = true
        passwordTextField.borderStyle = .none
    }

    private func setupView() {
        avatar.layer.cornerRadius = 60
        signUpButton.layer.cornerRadius = 18
        avatar.clipsToBounds = true
        avatar.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarDidTapped))
        avatar.addGestureRecognizer(tapGesture)
    }

    private func validateFields() {
        guard let username = usernameTextField.text, !username.isEmpty else {
            // print("Please enter a username")
            ProgressHUD.showError("Please enter a username")
            return
        }

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

    // MARK: - Actions

    @IBAction func signUpDidTapped(_ sender: UIButton) {
        validateFields()
        signUp {
            let scene = UIApplication.shared.connectedScenes.first
            if let sd: SceneDelegate = (scene?.delegate as? SceneDelegate) {
                sd.configureInitialViewController()
            }
        } onError: { errorMessage in
            ProgressHUD.showError(errorMessage)
        }

        }
    
}

// MARK: - PHPickerViewControllerDelegate

extension SignUpViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                if let imageSelected = image as? UIImage {
                    // print(imageSelected)
                    DispatchQueue.main.async {
                        self.avatar.image = imageSelected
                        self.image = imageSelected
                    }
                }
            }
        }

        dismiss(animated: true)
    }

    @objc private func avatarDidTapped() {
        var configuration: PHPickerConfiguration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1

        let pickerViewController = PHPickerViewController(configuration: configuration)
        pickerViewController.delegate = self
        present(pickerViewController, animated: true)
    }
}

extension SignUpViewController {
    private func signUp( onSuccess: @escaping() -> Void, onError:@escaping(_ errorMessage:String) -> Void) {
        ProgressHUD.show("Loading...")
        
        SignUpService.signUpApi.signUp(withUsername: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, image: image) {
//            print("Success")
            ProgressHUD.dismiss()
            onSuccess()
        } onError: { errorMessage in
            onError(errorMessage)
        }

    }
}
