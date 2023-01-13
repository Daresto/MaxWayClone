//
//  HomeViewController.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 09/11/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let menu = MenuList()
    
    private let homeFeedColletion: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeCollectionViewCell.self,
                                forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray5
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        homeFeedColletion.delegate = self
        homeFeedColletion.dataSource = self
        
        addConstraints()
        title = "Menu"
    }
    
    private func addConstraints() {
        view.addSubview(homeFeedColletion)
        
        NSLayoutConstraint.activate([
            homeFeedColletion.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            homeFeedColletion.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            homeFeedColletion.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            homeFeedColletion.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}




extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return menu.getTypeList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.foodInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(menu.foodInfo[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - 15, height: view.frame.width / 1.5)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as? HeaderCollectionReusableView else { return UICollectionReusableView() }
        header.configure(menu.getTypeList()[indexPath.section])
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DescriptionFoodViewController()
        vc.configuration(menu.foodInfo[indexPath.row])
        present(vc, animated: true)
    }
    
    
}
