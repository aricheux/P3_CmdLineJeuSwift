//
//  Weapon.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 27/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Define all weapon type available
enum weaponType : Int{
    case damage, healing
}

// Define the Weapon class
class Weapon{
    // Define the damage value for each attaque
    var damageValue : Int
    // Define the healing value for each heal
    var healValue : Int
    // Define the type of the weapon
    var type : weaponType
    
    // Initializes the new instance with defaut value
    init(){
        self.damageValue = 0
        self.type = .damage
        self.healValue = 0
    }
    
    // Initializes the new instance with property
    init(type: weaponType, damageValue: Int, healValue: Int) {
        self.damageValue = damageValue
        self.type = type
        self.healValue = healValue
    }
}
