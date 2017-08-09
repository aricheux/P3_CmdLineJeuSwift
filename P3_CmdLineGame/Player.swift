//
//  Player.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 27/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Define all action type available
enum ActionType: Int {
    case Attack
    case Heal
}

// Define the Player class
class Player {
    // Define the name of the player
    var name: String
    
    // Instance of character class
    var characters: [Character]
    
    // Boolean to know characters are alive on the player's team
    var isAlive: Bool
    
    // Initializes the new instance with property
    init(name: String) {
        self.isAlive = true
        self.name = name
        self.characters = []
    }
    
    // Check if characters are alive
    public func checkCharactersAlive() -> Bool {
        var indexDead: Int?
        var characterAlive = false
        
        if self.characters.count > 0 {
            for i in 0...self.characters.count-1 {
                if self.characters[i].life > 0 {
                    characterAlive = true
                } else {
                    indexDead = i
                }
            }
        }
        
        if let newIndexDead = indexDead {
            self.characters.remove(at: newIndexDead)
        }
        
        return characterAlive
    }
    
    // Choice the type of the character
    public func choiceCharacterType() {
        
        switch Global.input() {
        case 1:
            self.characters.append(Fighter())
        case 2:
            self.characters.append(Mage())
        case 3:
            self.characters.append(Colossus())
        case 4:
            self.characters.append(Dwarf())
        default:
            print("Veuillez entrer un numéro valide")
            choiceCharacterType()
        }
        
        print("Vous avez choisi le type \(self.characters[self.characters.count].typeName)")

    }
    
    // the player select who use
    public func selectCharacter() -> Character {
        var selectedCharacter = Character()
        
        print("A toi \(self.name), choisit un personnage dans ton équipe")
        
        self.introduceTeam()
        
        let selectionNumber = Global.input()
        
        if selectionNumber >= 1 && selectionNumber <= self.characters.count {
            selectedCharacter = self.characters[selectionNumber - 1]
            print("Tu as choisi", terminator: " ")
            selectedCharacter.introduceYou()
            print("")
        } else {
            print("Veuillez entrer un numéro valide")
            let _ = selectCharacter()
        }
        
        return selectedCharacter
    }
    
    // the player select the target
    public func selectTarget(selection: Character, adversary: Player) -> Character {
        var selectedTarget = Character()
        var selectedTeam = Player(name: "")
        
        if selection is Mage {
            print("Choisit un personnage à soigner dans ton équipe")
            selectedTeam = self
        } else {
            print("Choisit un personnage à attaquer dans l'équipe adverse")
            selectedTeam = adversary
        }
        
        selectedTeam.introduceTeam()
        
        let selectionNumber = Global.input()
        if selectionNumber >= 1 && selectionNumber <= selectedTeam.characters.count {
            selectedTarget = selectedTeam.characters[selectionNumber - 1]
        } else {
            print("Veuillez entrer un numéro valide")
            let _ = selectTarget(selection: selection, adversary: adversary)
        }
        
        return selectedTarget
    }
    
    private func introduceTeam() {
        for i in 0...self.characters.count - 1 {
            print("[\(i+1)]", terminator: " ")
            self.characters[i].introduceYou()
        }
        print("")
    }
}
