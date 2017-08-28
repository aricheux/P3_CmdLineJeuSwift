//
//  Mage.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 06/08/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Define the Class Mage
class Mage: Character {
    
    // Initializes with special poperty
    override init() {
        super .init()
        self.typeName = "Mage"
        self.life = 40
        self.weapon = Weapon(type: .Healing, healValue : 20)
    }
    
    // Override the mother function to add the value of heal
    override func introduceYou() {
        super.introduceYou()
        print("soin(\(self.weapon.healValue))")
    }
    
    // Override the mother function because the mage can only heal
    override func doAction(target: Character) {
        print("\(self.name) soigne \(target.name)")
        target.receveLife(life: self.weapon.healValue)
    }
    
}
