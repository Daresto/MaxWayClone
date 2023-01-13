//
//  ProfileViewController.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 09/11/22.
//

import UIKit


enum Rows: Int {
    case MyAccount = 0, Profile, MyAddress
}



class ProfileViewController: UIViewController {
    
    let settings = Settings()
    
    
    private let profileTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        table.backgroundColor = .systemGray5
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileTable.delegate = self
        profileTable.dataSource = self
        
        setupConstraints()
        
        view.backgroundColor = .systemGray5
        title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupConstraints() {
        view.addSubview(profileTable)
        
        profileTable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            profileTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            profileTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            profileTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
}



extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.settingsInfo.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = .white
        cell.configuration(settings.settingsInfo[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case Rows.MyAccount.rawValue:
            let vc = MyAccountViewController()
            navigationController?.pushViewController(vc, animated: true)
        case Rows.Profile.rawValue:
            let vc = BranchesViewController()
            navigationController?.pushViewController(vc, animated: true)
        case Rows.MyAddress.rawValue:
            let vc = MyAddress()
            present(vc, animated: true)
        default:
            break
        }
    }
    
    
}
