//
//  BranchesCollectionViewCell.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 17/11/22.
//

import UIKit

class BranchesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BranchesCollectionViewCell"
    
    
    private let cafeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "maxway")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    private let branchName: UILabel = {
        let label = UILabel()
        label.text = "TC Parus"
        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        return label
    }()
    
    
    private let locationName: UILabel = {
        let label = UILabel()
        label.text = "Katartal street, 60/5"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .gray
        return label
    }()
    
    
    private let clockImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "clock")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 75/256, green: 0, blue: 130/256, alpha: 1)
        return imageView
    }()
    
    
    private let workTime: UILabel = {
        let label = UILabel()
        label.text = " 9:00 - 03:00  "
        label.textColor = UIColor(red: 75/256, green: 0, blue: 130/256, alpha: 1)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        
        let stackView = UIStackView(arrangedSubviews: [clockImage, workTime])
        stackView.backgroundColor = UIColor(red: 203/256, green: 195/256, blue: 227/256, alpha: 1)
        stackView.layer.cornerRadius = 10
        
        
        contentView.addSubview(cafeImage)
        contentView.addSubview(branchName)
        contentView.addSubview(locationName)
        contentView.addSubview(stackView)
        
        cafeImage.translatesAutoresizingMaskIntoConstraints = false
        branchName.translatesAutoresizingMaskIntoConstraints = false
        locationName.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cafeImage.topAnchor.constraint(equalTo: topAnchor),
            cafeImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            cafeImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            cafeImage.heightAnchor.constraint(equalToConstant: (contentView.frame.width) * 9 / 16 ),
            
            branchName.topAnchor.constraint(equalTo: cafeImage.bottomAnchor, constant: 10),
            branchName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            locationName.topAnchor.constraint(equalTo: branchName.bottomAnchor, constant: 10),
            locationName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            stackView.topAnchor.constraint(equalTo: locationName.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.widthAnchor.constraint(equalToConstant: 150),
            stackView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(imageName: String, branchName: String, location: String) {
        cafeImage.image = UIImage(named: imageName)
        self.branchName.text = branchName
        locationName.text = location
    }
    
}
