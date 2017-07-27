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
    var damageValue : Int
    var healValue : Int
    var type : weaponType
    
    init(type: weaponType, damageValue: Int, healValue: Int) {
        self.damageValue = damageValue
        self.type = type
        self.healValue = healValue
    }
}
