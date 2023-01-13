//
//  MyOrdersViewController.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 09/11/22.
//

import UIKit
import CoreData

class MyOrdersViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var orders = [OrderedItems]()
    
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(KorzinkaItemsTableViewCell.self, forCellReuseIdentifier: KorzinkaItemsTableViewCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        setupNavBar()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getAllInfo()
    }

    
    
    // Setup our Methods
    func getAllInfo() {
        do {
            orders = try context.fetch(OrderedItems.fetchRequest())
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
    
    
    func createItems() {
        do {
            var models = [Item]()
            models = try context.fetch(Item.fetchRequest())
            
            for item in models {
                let newItem = OrderedItems(context: context)
                newItem.foodImageName = item.foodImageName
                newItem.numberOfItems = item.numberOfItems
                newItem.foodName = item.foodName
                newItem.foodPrice = item.foodPrice
                
                saveItem()
            }
            deletAllItemsInBasket()
        } catch {
            
        }
    }
    
    
    func deletAllItemsInBasket() {
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Item.fetchRequest())
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
            getAllInfo()
        } catch {
            
        }
    }
    
    
    // Setup our UI to the Screen
    func setupNavBar() {
        view.backgroundColor = .systemBackground
        title = "My orders"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}



extension MyOrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KorzinkaItemsTableViewCell.identifier, for: indexPath) as? KorzinkaItemsTableViewCell else { return UITableViewCell() }
        
        let item = orders[indexPath.row]
        cell.configure(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
