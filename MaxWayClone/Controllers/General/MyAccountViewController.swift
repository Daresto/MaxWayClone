//
//  MyAccountViewController.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 02/12/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MyAccountViewController: UIViewController {
    
    private let personImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.tintColor = .gray
        return imageView
    }()
    
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    
    lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log out", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        setupLayout()
        setupNavBar()
        setUserName()
    }
    
    
    // Methods
    
    private func setUserName() {
        let documentId = Auth.auth().currentUser!.uid
        let dataBase = Firestore.firestore()
        let docRef = dataBase.collection("users").document(documentId)
        
        docRef.getDocument { [weak self] document, error in
            if let document = document, document.exists {
                let docDescription = document.data()
                
                self?.fullNameLabel.text = docDescription!["firstname"] as? String
            }
        }
        
    }
    
    
    @objc private func logoutButtonTapped() {
        do {
            try Auth.auth().signOut()
        } catch {
            
        }
        
        if Auth.auth().currentUser == nil {
            view.window?.rootViewController = UINavigationController(rootViewController: SignUpViewController())
            view.window?.makeKeyAndVisible()
        }
    }
    
    
    
    // setup Our UI to the screen
    
    private func setupLayout() {
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        personImage.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoutButton)
        view.addSubview(personImage)
        view.addSubview(fullNameLabel)
        
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            
            personImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            personImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            personImage.widthAnchor.constraint(equalToConstant: 100),
            personImage.heightAnchor.constraint(equalToConstant: 100),
            
            fullNameLabel.topAnchor.constraint(equalTo: personImage.bottomAnchor, constant: 10),
            fullNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            fullNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
    }
    
    
    private func setupNavBar() {
        title = "Account Settings"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
