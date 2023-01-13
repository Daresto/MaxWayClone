//
//  KorzinkaViewController.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 09/12/22.
//

import UIKit
import CoreData

class KorzinkaViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var models = [Item]()
    
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(KorzinkaItemsTableViewCell.self, forCellReuseIdentifier: KorzinkaItemsTableViewCell.identifier)
        return table
    }()
    
    
    lazy var orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Order", for: .normal)
        button.backgroundColor = .red
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(orderDidTap), for: .touchUpInside)
        return button
    }()
    
    
    private let totalAmount: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = " Total amount: 0"
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        
        setupLayouts()
        setupNavBar()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllInfo()
    }
    
    
    // Methods
    
    func getAllInfo() {
        do {
            models = try context.fetch(Item.fetchRequest())
            var totalAmount = 0
            for item in models {
                totalAmount += Int(item.totalAmount)
            }
            self.totalAmount.text = " Total amount: \(totalAmount)"
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            
        }
    }
    
    
    func saveItem() {
        do {
            try context.save()
            getAllInfo()
        } catch {
            
        }
    }
    
    
    public func createItem(foodImageName: String, foodName: String, foodPrice: Int, numberOfItems: Int) {
        let newItem = Item(context: context)
        newItem.foodImageName = foodImageName
        newItem.foodName = foodName
        newItem.foodPrice = Int64(foodPrice)
        newItem.numberOfItems = Int64(numberOfItems)
        newItem.totalAmount = Int64(foodPrice * numberOfItems)
        
        saveItem()
    }
    
    
    func deleteItem(item: Item) {
        context.delete(item)
        saveItem()
    }
    
    
    @objc func deleteAllItems() {
        let alert = UIAlertController(title: "Delete All Items", message: "Do you really want to delete all items?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Item.fetchRequest())
            do {
                try self?.context.execute(batchDeleteRequest)
                try self?.context.save()
                self?.getAllInfo()
            } catch {
                
            }
        })
        present(alert, animated: true)
    }
    
    
    @objc func orderDidTap() {
        MyOrdersViewController().createItems()
        getAllInfo()
    }
    
    
    // Setup our UI to the Screen
    
    func setupLayouts() {
        let stackView = UIStackView(arrangedSubviews: [totalAmount, orderButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        view.addSubview(tableView)
        view.addSubview(stackView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: stackView.topAnchor)
        ])
    }
    
    
    func setupNavBar() {
        title = "Basket"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete All", style: .done, target: self, action: #selector(deleteAllItems))
    }
    
}


extension KorzinkaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KorzinkaItemsTableViewCell.identifier, for: indexPath) as? KorzinkaItemsTableViewCell else { return UITableViewCell() }
        
        cell.configure(model: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        
        let alert = UIAlertController(title: "Delete", message: "You really want to delete this item", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.deleteItem(item: item)
        })
        
        present(alert, animated: true)
    }
    
    
}
