//
//  Fighter.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 06/08/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Define the Class Fighter
class Fighter: Character {
    
    // Initializes with special poperty
    override init() {
        super .init()
        self.typeName = "Combattant"
        self.life = 100
        self.weapon = Weapon(type: .Damage, damageValue: 10)
    }
    
    // Override the mother function to add the value of damage
    override func introduceYou() {
        super.introduceYou()
        print("dégat(\(self.weapon.damageValue))")
    }
}
