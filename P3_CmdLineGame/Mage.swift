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
        self.type = .Mage
        self.life = 40
        self.weapon = Weapon(type: .Healing, damageValue: 20, healValue : 20)
    }
}
