//
//  Character.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 27/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Define all character type available
enum characterType : Int {
    case fighter, mage, colossus, dwarf
    
    static var count: Int { return characterType.dwarf.hashValue + 1}
}

// Define all action type available
enum actionType : Int{
    case attack, heal
    
    static var count: Int { return actionType.heal.hashValue + 1}
}

// Define the Character class
class Character {
    // Define the name of the character
    var name : String
    // Define the number of life remaining
    var life : Int{
        didSet{
            // Limited to 0
            if life < 0{
                life = 0
            }
            // Check if the character have more or less life
            if oldValue > life{
                print("\(name) perd \(oldValue - life) point de vie")
            }else{
                print("\(name) gagne \(life - oldValue) point de vie")
            }
            // status to know if the character is dead
            if life == 0{
                print("\(name) est mort..")
            }
        }
    }
    // Define the type of the character
    var type : characterType
    // Defines the weapon of the charact
    var weapon : Weapon
    
    // Initializes the new instance with all property
    init(type: characterType, name :String){
        self.type = type
        self.name = name
        
        // Define feature according to the type of character
        switch type {
        case .fighter:
            self.life = 100
            self.weapon = Weapon(type: .damage, damageValue: 10, healValue : 0)
        case .mage:
            self.life = 40
            self.weapon = Weapon(type: .healing, damageValue: 20, healValue : 20)
        case .colossus:
            self.life = 150
            self.weapon = Weapon(type: .damage, damageValue: 5, healValue : 0)
        case .dwarf:
            self.life = 50
            self.weapon = Weapon(type: .damage, damageValue: 30, healValue : 0)
        }
    }
}
