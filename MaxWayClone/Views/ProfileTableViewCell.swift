//
//  ProfileTableViewCell.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 14/11/22.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    static let identifier = "ProfileTableViewCell"
    
    private let itemImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "house.fill")
        imageView.image = image
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let itemName: UILabel = {
        let label = UILabel()
        label.text = "My Address"
        return label
    }()
    
    private let arrowRight: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .gray
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(itemImage)
        addSubview(itemName)
        addSubview(arrowRight)
        
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemName.translatesAutoresizingMaskIntoConstraints = false
        arrowRight.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            itemImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            itemImage.heightAnchor.constraint(equalToConstant: 35),
            itemImage.widthAnchor.constraint(equalToConstant: 35),
            
            itemName.centerYAnchor.constraint(equalTo: centerYAnchor),
            itemName.leadingAnchor.constraint(equalTo: itemImage.trailingAnchor, constant: 10),
            
            arrowRight.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowRight.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    
    public func configuration(_ model: SettingsModel) {
        var image = UIImage(systemName: model.itemImageName)
        image = image?.withRenderingMode(.alwaysOriginal)
        itemImage.image = image
        
        itemName.text = model.itemName
    }
}

