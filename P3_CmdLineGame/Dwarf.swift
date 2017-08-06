//
//  Dwarf.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 06/08/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Class Dwarf
class Dwarf: Character {
    
    // Initializes with special poperty
    override init() {
        super .init()
        self.type = .Dwarf
        self.life = 50
        self.weapon = Weapon(type: .Damage, damageValue: 30, healValue : 0)
    }
}
