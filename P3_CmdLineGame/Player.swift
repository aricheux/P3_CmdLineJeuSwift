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
    var name : String
    var characters : [Character]
    
    init(name : String){
        self.name = name
        self.characters = []
    }
    
    public func checkCharactersAlive() -> Bool{
        var characterAlive = false
        
        for i in 0...self.characters.count-1{
            if self.characters[i].life > 0{
                characterAlive = true
                break
            }
        }
        
        return characterAlive
    }
    
}
