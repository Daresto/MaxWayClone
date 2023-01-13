//
//  SignUpViewController.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 30/11/22.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    
    private var firstName = UITextField()
    
    private var lastName = UITextField()
    
    private var email = UITextField()
    
    private var password = UITextField()
    
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.alpha = 0
        label.textAlignment = .center
        label.textColor = .red
        return label
    }()
    
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("SIGN UP", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .light)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return button
    }()
    
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemGray4
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    lazy var goToLoginPageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(openLoginPage), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        addBackgroundGradients()
        setupLayout()
    }

    
    
    // our methods
    
    @objc private func signUpTapped() {
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        } else {
            
            let cleanedEmail = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let firstName = self.firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = self.lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create a user
            Auth.auth().createUser(withEmail: cleanedEmail, password: cleanedPassword) { [weak self] authResult, error in
                
                guard let self = self else { return }
                guard let authResult = authResult else { return }
                
                if error != nil {
                    self.showError("Error creating user")
                } else {
                    
                    // User was created successfully, now store a first name and a last name
                    let dataBase = Firestore.firestore()
                    let uid = authResult.user.uid
                    let docId = uid
                    
                    dataBase.collection("users").document(docId).setData(["firstname": firstName, "lastname": lastName, "uid": authResult.user.uid])
                    
                    // Transition the home screen
                    self.view.window?.rootViewController = MainTabBarViewController()
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
    }
    
    
    @objc private func openLoginPage() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    
    func validateFields() -> String? {
        
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Plese fill in all fields"
        }
        
        let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isValidPassword(password: cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters, contains a uppercase and a lowercase and a number"
        }
        
        return nil
    }
    
    
    func isValidPassword(password: String) -> Bool {
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    
    // setup our UI to the screen
    
    private func setupLayout() {
        firstName = self.addTextField(frame: .zero, placeholder: "Firstname", imageName: "person")
        lastName = self.addTextField(frame: .zero, placeholder: "Lastname", imageName: "person")
        email = self.addTextField(frame: .zero, placeholder: "Email", imageName: "envelope")
        password = self.addTextField(frame: .zero, placeholder: "Password", imageName: "lock")
        let stackView = UIStackView(arrangedSubviews: [firstName, lastName, email, password, signUpButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        let stackForLoginPage = UIStackView(arrangedSubviews: [label, goToLoginPageButton])
        stackForLoginPage.axis = .horizontal
        stackForLoginPage.spacing = 5
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        firstName.translatesAutoresizingMaskIntoConstraints = false
        stackForLoginPage.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addSubview(stackForLoginPage)
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            firstName.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width - 60),
            
            stackForLoginPage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackForLoginPage.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            
        ])
        
    }
    
    
    private func addBackgroundGradients() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.systemPurple.cgColor,
            UIColor.systemRed.cgColor
        ]
        view.layer.addSublayer(gradientLayer)
    }
    
    
    
}
