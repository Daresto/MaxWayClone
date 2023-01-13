//
//  ViewController.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 09/11/22.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: MyOrdersViewController())
        let vc3 = UINavigationController(rootViewController: ProfileViewController())
        let vc4 = UINavigationController(rootViewController: KorzinkaViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house.circle")
        vc2.tabBarItem.image = UIImage(systemName: "cart.circle")
        vc3.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        vc4.tabBarItem.image = UIImage(systemName: "trash.circle")
        
        vc1.tabBarItem.title = "Menu"
        vc2.tabBarItem.title = "My orders"
        vc3.tabBarItem.title = "Profile"
        vc4.tabBarItem.title = "Basket"
        
        tabBar.tintColor = UIColor(red: 75/256, green: 0, blue: 130/256, alpha: 1)
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
        
    }


}
