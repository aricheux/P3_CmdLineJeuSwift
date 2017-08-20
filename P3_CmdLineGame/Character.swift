//
//  Character.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 27/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Define the Character class
class Character {
    
    // Define the name of the character
    var name: String
    
    // Define the name of the type
    var typeName: String
    
    // Define the number of armor remaining
    var armor: Int
    
    // Define the number of life remaining
    var life: Int
    
    // Defines the weapon of the character
    var weapon: Weapon
    
    // Initializes the new instance with default value
    init() {
        self.name = "Character"
        self.life = 100
        self.armor = 0
        self.typeName = "Type"
        self.weapon = Weapon()
    }
    
    // Function to show all data of the character
    public func introduceYou() {
        print("\(self.name) (\(self.typeName)): vie(\(self.life)) armure(\(self.armor))", terminator: " ")
    }

    // Execute the the action to the target
    public func doAction(target: Character) {
        print("\(self.name) attaque \(target.name)")
        target.receveDamage(damage: self.weapon.damageValue)
    }
    
    // Function to update life and armor when the character receve damage
    public func receveDamage(damage: Int) {
        let oldLife = self.life
        let oldArmor = self.armor
        
        if self.armor < damage {
            self.life -= damage - self.armor
            if self.life < 0 { self.life = 0 }
            
            print("\(self.name) perd \(oldLife - self.life) points de vie")
        }
        
        self.armor -= damage
        if self.armor < 0 { self.armor = 0 }
        
        if oldArmor > self.armor {
            print("\(self.name) perd \(oldArmor - self.armor) points d'armure")
        }
    }
    
    // Function to update the life value when the character receve life from box or mage
    public func receveLife(life: Int) {
        let oldLife = self.life
        
        self.life += life
        print("\(self.name) gagne \(self.life - oldLife) points de vie")
    }
    
    // Function to update the armor value when the character receve armor from box
    public func receveArmor(armor: Int) {
        let oldArmor = self.armor
        
        self.armor += armor
        print("\(self.name) gagne \(self.armor - oldArmor) points d'armure")
    }
    
}
