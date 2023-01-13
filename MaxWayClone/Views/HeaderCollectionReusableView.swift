//
//  HeaderCollectionReusableView.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 10/11/22.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "HeaderCollectionReusableView"
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Header"
        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        label.backgroundColor = .systemGray5
        return label
    }()
    
    public func configure(_ title: String) {
        backgroundColor = .red
        headerLabel.text = title
        addSubview(headerLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.frame = bounds
    }
}
