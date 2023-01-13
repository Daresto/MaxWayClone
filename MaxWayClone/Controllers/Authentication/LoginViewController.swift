//
//  LoginViewController.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 30/11/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
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
    
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("LOG IN", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .light)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 7
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBackgroundGradients()
        setupLayout()
    }
    
    
    
    // Methods
    
    @objc private func loginButtonTapped() {
        
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        } else {
            
            let cleanedEmail = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let cleanedPassword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: cleanedEmail, password: cleanedPassword) { [weak self] authResult, error in
                
                if error != nil {
                    self?.showError(error?.localizedDescription ?? "Oups something went wrong")
                } else {
                    self?.view.window?.rootViewController = MainTabBarViewController()
                    self?.view.window?.makeKeyAndVisible()
                }
            }
        }
        
    }
    
    
    func validateFields() -> String? {
        
        if email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
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
    
    
    // Setup our UI to the screen
    
    private func setupLayout() {
        email = self.addTextField(frame: .zero, placeholder: "Email", imageName: "envelope")
        password = self.addTextField(frame: .zero, placeholder: "Password", imageName: "lock")
        let stackView = UIStackView(arrangedSubviews: [email, password, loginButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        email.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            email.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width - 60)
        ])
        
    }
    
    
    private func addBackgroundGradients() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.systemRed.cgColor,
            UIColor.systemPurple.cgColor
        ]
        view.layer.addSublayer(gradientLayer)
    }
    
}
