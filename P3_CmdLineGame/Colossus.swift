//
//  Colossus.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 06/08/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Class Colossus
class Colossus: Character {
    
    // Initializes with special poperty
    override init() {
        super .init()
        self.type = .Colossus
        self.life = 150
        self.weapon = Weapon(type: .Damage, damageValue: 5, healValue : 0)
    }
}
