//
//  KorzinkaItemsTableViewCell.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 10/12/22.
//

import UIKit

class KorzinkaItemsTableViewCell: UITableViewCell {
    
    static let identifier = "KorzinkaItemsTableViewCell"
    
    
    private let foodImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    private let foodName: UILabel = {
        let label = UILabel()
        label.text = "Vafli"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    
    private let foodPrice: UILabel = {
        let label = UILabel()
        label.text = "35 000 so'm"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    
    private let numberOfItems: UILabel = {
        let label = UILabel()
        label.text = "1x"
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configure(model: Item) {
        foodImage.image = UIImage(named: model.foodImageName ?? "")
        foodName.text = model.foodName
        foodPrice.text = String(model.foodPrice) + " so'm"
        numberOfItems.text = String(model.numberOfItems) + "x"
    }
    
    
    public func configure(with model: OrderedItems) {
        foodImage.image = UIImage(named: model.foodImageName ?? "")
        foodName.text = model.foodName
        foodPrice.text = String(model.foodPrice) + " so'm"
        numberOfItems.text = String(model.numberOfItems) + "x"
    }
    
    
    private func setupLayouts() {
        addSubview(foodImage)
        addSubview(foodName)
        addSubview(foodPrice)
        addSubview(numberOfItems)
        
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        foodName.translatesAutoresizingMaskIntoConstraints = false
        foodPrice.translatesAutoresizingMaskIntoConstraints = false
        numberOfItems.translatesAutoresizingMaskIntoConstraints = false
         
        NSLayoutConstraint.activate([
            foodImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            foodImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            foodImage.heightAnchor.constraint(equalToConstant: 80),
            foodImage.widthAnchor.constraint(equalToConstant: 80),
            
            foodName.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            foodName.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor, constant: 15),
            foodName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            foodPrice.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor, constant: 15),
            foodPrice.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            numberOfItems.centerYAnchor.constraint(equalTo: centerYAnchor),
            numberOfItems.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
}
