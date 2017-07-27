//
//  Character.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 27/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

enum characterType : Int {
    case fighter, mage, colossus, dwarf
}

// Character class
class Character {
    var name : String
    var life : Int
    var type : characterType
    var weapon : Weapon
    
    init(type: characterType, name :String){
        self.type = type
        self.name = name
        
        // Define feature according to the type of character
        switch type {
        case .fighter:
            self.life = 100
            self.weapon = Weapon(type: .damage, damage: 10, healing : 0)
        case .mage:
            self.life = 50
            self.weapon = Weapon(type: .healing, damage: 20, healing : 20)
        case .colossus:
            self.life = 200
            self.weapon = Weapon(type: .damage, damage: 5, healing : 0)
        case .dwarf:
            self.life = 40
            self.weapon = Weapon(type: .damage, damage: 30, healing : 0)
        }
    }
}
