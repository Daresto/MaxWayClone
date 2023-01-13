//
//  MenuModel.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 10/11/22.
//

import Foundation

struct Food {
    let imageName: String
    let foodName: String
    let price: Int
    let description: String
}

struct Branches {
    let imageName: String
    let location: String
    let banchName: String
}

struct MenuList {
    let typeList = [ "Locmacco", "Napitki"]
    
    let foodInfo = [
        Food(imageName: "1", foodName: "Shokoladli Belgiya Vaflisi", price: 25000, description: "Lamian is a type of soft wheat flour Chinese noodle that is particularly common in northern China. Lamian is made by twisting, stretching and folding the dough into strands, using the weight of the dough. The length and thickness of the strands depends on the number of times the dough is folded."),
        Food(imageName: "2", foodName: "Bananli Gonkong Vaflisi", price: 32000, description: "Traditional Russian blini are made with yeasted batter, which is left to rise and then diluted with milk, soured milk, cold or boiling water. When diluted with boiling water, they are referred to as zavarniye bliny."),
        Food(imageName: "3", foodName: "Qulupnayli Belgiya Vaflisi", price: 2000, description: "Singaras may be eaten as a tea time snack. They can also be prepared in a sweet form. Bengali singaras tend to be triangular, filled with potato, peas, onions, diced almonds, or other vegetables, and are more heavily fried and crunchier than either singaras or their Indian samosa cousins."),
        Food(imageName: "4", foodName: "Qulupnayli Gonkong Vaflisi", price: 32000, description: "The garden strawberry (or simply strawberry; Fragaria × ananassa) is a widely grown hybrid species of the genus Fragaria, collectively known as the strawberries, which are cultivated worldwide for their fruit. The fruit is widely appreciated for its characteristic aroma, bright red color, juicy texture, and sweetness."),
    ]
    
    
    func getTypeList() -> [String] {
        return typeList
    }
}


struct BracnchesList {
    let branchesInfo = [
        Branches(imageName: "maxway1", location: "Qatortol street", banchName: "TC Parus"),
        Branches(imageName: "maxway2", location: "Qatortol street", banchName: "TC Parus"),
        Branches(imageName: "maxway3", location: "Qatortol street", banchName: "TC Parus"),
        Branches(imageName: "maxway4", location: "Qatortol street", banchName: "TC Parus")
    ]
}
