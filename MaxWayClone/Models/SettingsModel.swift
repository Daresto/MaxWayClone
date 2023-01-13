//
//  SettingsModel.swift
//  MaxWayClone
//
//  Created by  Abdurahmon on 14/11/22.
//

import Foundation

struct SettingsModel {
    let itemImageName: String
    let itemName: String
}

struct Settings {
    let settingsInfo = [
        SettingsModel(itemImageName: "person.crop.square.fill", itemName: "My Account"),
        SettingsModel(itemImageName: "mappin.square.fill", itemName: "Branches"),
        SettingsModel(itemImageName: "location.square.fill", itemName: "My Address")
    ]
    
}
