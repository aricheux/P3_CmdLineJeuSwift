//
//  Weapon.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 27/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Define all weapon type available
enum WeaponType: Int{
    case damage
    case healing
}

// Define the Weapon class
class Weapon {
    
    // Define the damage value for each attaque
    var damageValue: Int
    
    // Define the healing value for each heal
    var healValue: Int
    
    // Define the type of the weapon
    var type: WeaponType
        
    // Initializes the new instance with property
    init(type: WeaponType = .damage, damageValue: Int = 0, healValue: Int = 0) {
        self.damageValue = damageValue
        self.type = type
        self.healValue = healValue
    }
}
