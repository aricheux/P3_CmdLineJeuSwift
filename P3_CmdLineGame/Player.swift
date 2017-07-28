//
//  Player.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 27/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Player class
class Player{
    // Define the name of the player
    var name : String
    // Instance of character class
    var characters : [Character]
    
    // Initializes the new instance with property
    init(name : String){
        self.name = name
        self.characters = []
    }
    // Check if characters are alive to continu the game
    public func checkCharactersAlive() -> Bool{
        var indexDead : Int?
        var characterAlive = false
        
        for i in 0...self.characters.count-1{
            if self.characters[i].life > 0{
                characterAlive = true
            }else{
                indexDead = i
            }
        }
        // Check if a character is dead during the turn
        if indexDead != nil{
            // Remove the character to the game
            self.characters.remove(at: indexDead!)
        }
        return characterAlive
    }
    
}
