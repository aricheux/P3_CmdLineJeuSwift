//
//  Dwarf.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 06/08/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Define Class Dwarf
class Dwarf: Character {
    
    // Initializes with special poperty
    override init() {
        super .init()
        self.typeName = "Nain"
        self.life = 50
        self.weapon = Weapon(type: .Damage, damageValue: 30, healValue : 0)
    }
    
    // Override the mother function to add the value of damage
    override func introduceYou() {
        super.introduceYou()
        print("dégat(\(self.weapon.damageValue))")
    }
}
