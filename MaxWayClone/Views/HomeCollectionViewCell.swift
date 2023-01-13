//
//  HomeCollectionViewCell.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 10/11/22.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCell"
    
    private let foodImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "1")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let foodName: UILabel = {
        let label = UILabel()
        label.text = "hello"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .gray
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "35 000"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.backgroundColor = UIColor(red: 75/256, green: 0, blue: 130/256, alpha: 1)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
        addConstraints()
    }
    
    
    private func addConstraints() {
        let stackView = UIStackView(arrangedSubviews: [foodName, containerView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        
        contentView.addSubview(foodImage)
        contentView.addSubview(stackView)
        containerView.addSubview(price)
        
        
        
        NSLayoutConstraint.activate([
            foodImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            foodImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            foodImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            
            stackView.topAnchor.constraint(equalTo: foodImage.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            price.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            price.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            price.widthAnchor.constraint(equalToConstant: 70),
            price.heightAnchor.constraint(equalToConstant: 30),
            
        ])
        
    }
    
    public func configure(_ food: Food) {
        foodImage.image = UIImage(named: food.imageName)
        self.foodName.text = food.foodName
        self.price.text = "\(food.price)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
