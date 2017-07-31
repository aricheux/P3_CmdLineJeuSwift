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
    
    // Initializes the new instance with property
    init(name: String) {
        self.name = name
        self.characters = []
    }
    // Check if characters are alive
    public func checkCharactersAlive() -> Bool {
        var indexDead: Int?
        var characterAlive = false
        for i in 0...self.characters.count-1 {
            if self.characters[i].life > 0 {
                characterAlive = true
            } else {
                indexDead = i
            }
        }
        // Check if a character is dead during the turn
        if indexDead != nil {
            // Remove the character to the game
            self.characters.remove(at: indexDead!)
        }
        return characterAlive
    }
    // Choice the type of the character
    public func choiceCharacterType() -> Bool {
        var characterTypeOk = false
        let numSelection = selectionFromUser()
        if numSelection > 0 {
            switch numSelection {
            case 1...4:
                // subtract 1 to match with the enumeration
                self.characters.append(Character(type: CharacterType(rawValue: numSelection-1)!, name:"Character"))
                print("Vous avez choisi le type \(CharacterType(rawValue: numSelection-1)!)")
                characterTypeOk = true
            default:
                print("Veuillez entrer un numéro valide")
            }
        }
        return characterTypeOk
    }
    // the player select who use
    public func selectCharacter() -> Character? {
        var selectedCharacter: Character?
        print("A toi \(self.name), choisit un personnage dans ton équipe ")
        for i in 0...self.characters.count-1 {
            print("[\(i+1)] ----- \(self.characters[i].name) :"
                + " vie(\(self.characters[i].life))"
                + " dégat(\(self.characters[i].weapon.damageValue))", terminator: "")
            if self.characters[i].type == .mage{
                print(" soin(\(self.characters[i].weapon.healValue))", terminator: "")
            }
            print("")
        }
        // Recovery the value entered by the player
        let numSelection = selectionFromUser()
        if numSelection > 0 {
            switch numSelection {
            case 1...self.characters.count:
                selectedCharacter = self.characters[numSelection-1]
                
                print("Tu as choisi \(selectedCharacter!.name) :"
                    + " vie(\(selectedCharacter!.life))"
                    + " dégat(\(selectedCharacter!.weapon.damageValue))", terminator: "")
                if selectedCharacter!.type == .mage{
                    print(" soin(\(selectedCharacter!.weapon.healValue))", terminator: "")
                }
                print("\n")
            default:
                print("Veuillez entrer un numéro valide")
            }
        }
        return selectedCharacter
    }
    // the player select the action to do
    public func selectedAction() -> actionType? {
        var selectedAction: actionType?
        
        print("Que voulez vous faire : [1]---- Attaquer [2]---- Soigner")
        // Recovery the value entered by the player
        let numSelection = selectionFromUser()
        if numSelection > 0 {
            switch numSelection {
            case 1...actionType.count:
                selectedAction = actionType(rawValue: numSelection-1)
            default:
                print("Veuillez entrer un numéro valide")
            }
        }
        return selectedAction
    }
    // Show the actual status of the team
    public func showTeamStatus() {
        
    }
    // Recovery the value entered by the player
    public func selectionFromUser() -> Int {
        var numSelection = 0
        if let response = readLine(){
            if response.isStringAnInt {
                numSelection = Int(response)!
            }else{
                print("Veuillez entrer un numéro valide")
            }
        }
        return numSelection
    }

    
}
