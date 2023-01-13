//
//  BranchesViewController.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 26/11/22.
//

import UIKit

class BranchesViewController: UIViewController {
    
    let branches = BracnchesList().branchesInfo
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemGray4
        cv.register(BranchesCollectionViewCell.self, forCellWithReuseIdentifier: BranchesCollectionViewCell.identifier)
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        setupNavigation()
    }
    
    
    private func setupNavigation() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "MaxWay"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = UIColor(red: 75/256, green: 0, blue: 130/256, alpha: 1)
        navigationItem.titleView = titleLabel
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
}


extension BranchesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return branches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BranchesCollectionViewCell.identifier, for: indexPath) as? BranchesCollectionViewCell else { return UICollectionViewCell() }
        
        let branch = branches[indexPath.row]
        cell.configure(imageName: branch.imageName, branchName: branch.banchName, location: branch.location)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 330)
    }
}
