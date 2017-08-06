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
    var name: String
    
    // Define the number of armor remaining
    var armor: Int {
        didSet{
            if oldValue > armor {
                print("\(name) perd \(oldValue - armor) points d'armure")
            } else {
                print("\(name) gagne \(armor - oldValue) points d'armure")
            }
        }
    }
    
    // Define the number of life remaining
    var life: Int {
        didSet {
            if oldValue > life {
                if armor >= (oldValue - life) {
                    armor -= (oldValue - life)
                    life = oldValue
                } else if armor > 0 {
                    life = life + armor
                    armor -= armor
                }
                if life < 0 {
                    life = 0
                }
                if oldValue > life {
                    print("\(name) perd \(oldValue - life) points de vie")
                }
            } else {
                print("\(name) gagne \(life - oldValue) points de vie")
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
    
    // Initializes the new instance with default value
    init() {
        self.name = "Character"
        self.life = 100
        self.armor = 0
        self.type = .Fighter
        self.weapon = Weapon()
    }
    
}
