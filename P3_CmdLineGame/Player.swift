//
//  Player.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 27/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Define the Player class
class Player {
    // Define the name of the player
    var name: String
    
    // Instance of character class
    var characters: [Character]
    
    // Boolean to know if characters are alive on the player's team
    var isAlive: Bool
    
    // Initializes the new instance with property
    init(name: String) {
        self.isAlive = true
        self.name = name
        self.characters = []
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
    public func selectCharacter() -> Character? {
        var selectedCharacter: Character?
        
        print("A toi \(self.name), choisit un personnage dans ton équipe")
        self.introduceTeam()
        
        let selectionNumber = Global.input()
        if selectionNumber >= 1 && selectionNumber <= self.characters.count {
            print("Tu as choisi ", terminator: "")
            self.characters[selectionNumber - 1].introduceYou()
            print("")
            selectedCharacter = self.characters[selectionNumber - 1]
        } else {
            print("Veuillez entrer un numéro valide")
            selectedCharacter = selectCharacter()
        }
        
        return selectedCharacter
    }
    
    // the player select the target
    public func selectTarget(selection: Character, adversary: Player) -> Character? {
        var selectedTarget: Character?
        var selectedPlayer = Player(name: "")
        
        if selection is Mage {
            print("Choisit un personnage à soigner dans ton équipe")
            selectedPlayer = self
        } else {
            print("Choisit un personnage à attaquer dans l'équipe adverse")
            selectedPlayer = adversary
        }
        
        selectedPlayer.introduceTeam()
        
        let selectionNumber = Global.input()
        if selectionNumber >= 1 && selectionNumber <= selectedPlayer.characters.count {
            selectedTarget = selectedPlayer.characters[selectionNumber - 1]
        } else {
            print("Veuillez entrer un numéro valide")
            selectedTarget = selectTarget(selection: selection, adversary: adversary)
        }
        
        return selectedTarget
    }
    
    // Update of the team's character
    public func updateTeam() {
        var indexDead: Int?
        isAlive = false
        
        for i in 0...self.characters.count - 1 {
            if self.characters[i].life == 0 {
                print("\(self.characters[i].name) est mort..")
                indexDead = i
            } else {
                isAlive = true
            }
        }
        
        if let newIndexDead = indexDead {
            self.characters.remove(at: newIndexDead)
        }
        
        print("")
    }
    
    // Introduce all character available in the team
    private func introduceTeam() {
        for i in 0...self.characters.count - 1 {
            print("\(i+1) - ", terminator: "")
            self.characters[i].introduceYou()
        }
        print("")
    }
}
