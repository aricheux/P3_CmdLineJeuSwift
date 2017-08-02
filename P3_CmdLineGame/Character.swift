//
//  Character.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 27/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Define all character type available
enum CharacterType: Int {
    case Fighter
    case Mage
    case Colossus
    case Dwarf
}

// Define the Character class
class Character {
    // Define the name of the character
    var name: String = "Character"
    
    // Define the number of armor remaining
    var armor : Int
    
    // Define the number of life remaining
    var life: Int {
        didSet {
            if life < 0 {
                life = 0
            }
            if oldValue > life {
                print("\(name) perd \(oldValue - life) point de vie")
            } else {
                print("\(name) gagne \(life - oldValue) point de vie")
            }
            if (life == 0) {
                print("\(name) est mort..")
            }
        }
    }
    // Define the type of the character
    var type: CharacterType
    
    // Defines the weapon of the character
    var weapon: Weapon
    
    // Initializes the new instance
    init(type: CharacterType) {
        self.type = type
        self.armor = 0
        
        switch type {
        case .Fighter:
            self.life = 100
            self.weapon = Weapon(type: .Damage, damageValue: 10, healValue : 20)
        case .Mage:
            self.life = 40
            self.weapon = Weapon(type: .Healing, damageValue: 20, healValue : 20)
        case .Colossus:
            self.life = 150
            self.weapon = Weapon(type: .Damage, damageValue: 5, healValue : 0)
        case .Dwarf:
            self.life = 50
            self.weapon = Weapon(type: .Damage, damageValue: 30, healValue : 0)
        }
    }
}

// Class Fighter
class Fighter: Character {
    
    // Initializes with special poperty
    init() {
        super .init(type: .Fighter)
    }
}

// Class Mage
class Mage: Character {
    
    // Initializes with special poperty
    init() {
        super .init(type: .Mage)
    }
}

// Class Colossus
class Colossus: Character {
    
    // Initializes with special poperty
    init() {
        super .init(type: .Colossus)
    }
}

// Class Dwarf
class Dwarf: Character {
    
    // Initializes with special poperty
    init() {
        super .init(type: .Dwarf)
    }
}
