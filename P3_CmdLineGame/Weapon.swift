//
//  Weapon.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 27/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

enum weaponType : Int{
    case damage, healing
}

// Weapon class
class Weapon{
    var damage : Int
    var healing : Int
    var type : weaponType
    
    init(type: weaponType, damage: Int, healing: Int) {
        self.damage = damage
        self.type = type
        self.healing = healing
    }
}
