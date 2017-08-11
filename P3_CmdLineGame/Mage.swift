//
//  Mage.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 06/08/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Class Mage
class Mage: Character {
    
    // Initializes with special poperty
    override init() {
        super .init()
        self.typeName = "Mage"
        self.life = 40
        self.weapon = Weapon(type: .Healing, damageValue: 20, healValue : 20)
    }
    
    override func introduceYou() {
        super.introduceYou()
        print("soin(\(self.weapon.healValue))")
    }
    
    override func doAction(target: Character) {
        print("\(self.name) soigne \(target.name)")
        target.receveLife(life: self.weapon.healValue)
    }
    
}
