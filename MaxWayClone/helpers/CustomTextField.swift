//
//  CustomTextField.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 30/11/22.
//

import UIKit


extension UIViewController {
    
    func addTextField(frame: CGRect, placeholder: String, imageName: String) -> UITextField {
        let field = UITextField()
        
        field.leftViewMode = .always
        let paddingView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        let image = UIImage(systemName: imageName)
        paddingView.image = image
        paddingView.tintColor = UIColor.systemGray3
        field.leftView = paddingView
        
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: 48, width: view.frame.width - 60, height: 1)
        bottomLine.backgroundColor = UIColor.systemGray4.cgColor
        
        field.borderStyle = .none
        field.layer.addSublayer(bottomLine)
        field.attributedPlaceholder = NSAttributedString(
            string: "  \(placeholder)",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4]
        )
        
        return field
    }
    
}
