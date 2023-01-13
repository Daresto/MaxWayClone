//
//  DescriptionFoodViewController.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 13/11/22.
//

import UIKit

class DescriptionFoodViewController: UIViewController {
    
    private var model: Food?
    
    private let foodImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "1")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let foodName: UILabel = {
        let label = UILabel()
        label.text = "Locmacco"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let foodDescription: UILabel = {
        let label = UILabel()
        label.text = "The garden strawberry (or simply strawberry; Fragaria × ananassa) is a widely grown hybrid species of the genus Fragaria, collectively known as the strawberries, which are cultivated worldwide for their fruit. The fruit is widely appreciated for its characteristic aroma, bright red color, juicy texture, and sweetness."
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private let foodPrice: UILabel = {
        let label = UILabel()
        label.text = "35 000 so'm"
        label.font = UIFont.systemFont(ofSize: 27)
        return label
    }()
     
    private let numberOfSelectedItems: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        return label
    }()
    
    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.stepValue = 1
        stepper.minimumValue = 1
        stepper.value = 1
        stepper.addTarget(self, action: #selector(stepperTapped), for: .valueChanged)
        return stepper
    }()
    
    private lazy var korzinkaButton: UIButton = {
        let button = UIButton()
        button.setTitle("Korzinkaga qo'shish", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(korzinkaButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupConstraints()
    }
    
    
    // Methods
    
    public func configuration(_ model: Food) {
        self.model = model
        foodImage.image = UIImage(named: model.imageName)
        foodName.text = model.foodName
        foodPrice.text = "\(model.price) so'm"
        foodDescription.text = model.description
    }
    
    
    @objc func korzinkaButtonTapped() {
        korzinkaButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { [weak self] in
            self?.korzinkaButton.alpha = 1.0
        }
        
        guard let model = model else { return }
        
        KorzinkaViewController().createItem(foodImageName: model.imageName, foodName: model.foodName, foodPrice: model.price, numberOfItems: Int(stepper.value))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    
    @objc func stepperTapped() {
        numberOfSelectedItems.text = "\(Int(stepper.value))"
    }
    
    
    
    
    // Setup our UI to the Screen
    
    private func setupConstraints() {
        view.addSubview(foodImage)
        view.addSubview(foodName)
        view.addSubview(foodDescription)
        view.addSubview(foodPrice)
        view.addSubview(numberOfSelectedItems)
        view.addSubview(stepper)
        view.addSubview(korzinkaButton)
        
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        foodName.translatesAutoresizingMaskIntoConstraints = false
        foodDescription.translatesAutoresizingMaskIntoConstraints = false
        foodPrice.translatesAutoresizingMaskIntoConstraints = false
        numberOfSelectedItems.translatesAutoresizingMaskIntoConstraints = false
        stepper.translatesAutoresizingMaskIntoConstraints = false
        korzinkaButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            foodImage.topAnchor.constraint(equalTo: view.topAnchor),
            foodImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            foodImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            foodImage.heightAnchor.constraint(equalToConstant: 350),
            
            foodName.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 10),
            foodName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            foodName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            foodDescription.topAnchor.constraint(equalTo: foodName.bottomAnchor, constant: 15),
            foodDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            foodDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            korzinkaButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            korzinkaButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            korzinkaButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            korzinkaButton.heightAnchor.constraint(equalToConstant: 45),
            
            foodPrice.bottomAnchor.constraint(equalTo: korzinkaButton.topAnchor, constant: -25),
            foodPrice.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            stepper.bottomAnchor.constraint(equalTo: korzinkaButton.topAnchor, constant: -25),
            stepper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            numberOfSelectedItems.bottomAnchor.constraint(equalTo: korzinkaButton.topAnchor, constant: -25),
            numberOfSelectedItems.trailingAnchor.constraint(equalTo: stepper.leadingAnchor, constant: -25)
        ])
    }
    
}
