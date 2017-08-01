//
//  Player.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 27/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

extension String {
    var isStringAnInt: Bool {
        return Int(self) != nil
    }
}

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
        
        if let newIndexDead = indexDead {
            self.characters.remove(at: newIndexDead)
        }
        
        return characterAlive
    }
    
    // Choice the type of the character
    public func choiceCharacterType() -> Bool {
        var characterTypeOk = false
        let numSelection = selectionFromUser()
        
        if numSelection > 0 {
            if numSelection >= 1 && numSelection <= 4 {
                if let charactType = CharacterType(rawValue: numSelection-1) {
                    print("Vous avez choisi le type \(charactType)")
                    
                    switch charactType {
                    case .Fighter:
                        self.characters.append(Fighter())
                    case .Mage:
                        self.characters.append(Mage())
                    case .Colossus:
                        self.characters.append(Colossus())
                    case .Dwarf:
                        self.characters.append(Dwarf())
                    }
                    characterTypeOk = true
                }
            } else {
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
            if self.characters[i].type == .Mage {
                print(" soin(\(self.characters[i].weapon.healValue))", terminator: "")
            }
            print("")
        }
        
        let numSelection = selectionFromUser()
        if numSelection > 0 {
            if numSelection >= 1 && numSelection <= self.characters.count {
                print("Tu as choisi \(self.characters[numSelection-1].name) :"
                    + " vie(\(self.characters[numSelection-1].life))"
                    + " dégat(\(self.characters[numSelection-1].weapon.damageValue))", terminator: "")
                if self.characters[numSelection-1].type == .Mage{
                    print(" soin(\(self.characters[numSelection-1].weapon.healValue))", terminator: "")
                }
                print("\n")
                selectedCharacter = self.characters[numSelection-1]
            } else {
                print("Veuillez entrer un numéro valide")
            }
        }
        
        return selectedCharacter
    }
    
    // the player select the action to do
    public func selectedAction(charactType : CharacterType) -> actionType? {
        var selectedAction: actionType?
        
        if charactType == .Mage {
            let numSelection = selectionFromUser()
            
            print("Que voulez vous faire : [1]---- Attaquer [2]---- Soigner")
            
            if numSelection > 0 {
                if numSelection >= 1 && numSelection <= self.characters.count {
                    selectedAction = actionType(rawValue: numSelection-1)
                } else {
                    print("Veuillez entrer un numéro valide")
                }
            }
        } else {
            selectedAction = .Attack
        }
        
        return selectedAction
    }
    
    // the player select the target
    public func selectedTarget(adversary: Player, action: actionType) -> Character? {
        var targetCharacter: Character?
        var characCount: Int
        
        switch action {
        case .Attack:
            print("Choisissez qui attaquer dans l'équipe de \(adversary.name) :")
            for i in 0...adversary.characters.count-1 {
                print("[\(i+1)] ----- \(adversary.characters[i].name) :"
                    + " vie(\(adversary.characters[i].life))"
                    + " dégat(\(adversary.characters[i].weapon.damageValue))", terminator: "")
                if adversary.characters[i].type == .Mage {
                    print(" soin(\(adversary.characters[i].weapon.healValue))", terminator: "")
                }
                print("")
            }
            
        case .Heal:
            print("Choisissez qui soigner dans votre équipe :")
            for i in 0...self.characters.count-1 {
                print("[\(i+1)] ----- \(self.characters[i].name) :"
                    + " vie(\(self.characters[i].life))"
                    + " dégat(\(self.characters[i].weapon.damageValue))", terminator: "")
                if self.characters[i].type == .Mage {
                    print(" soin(\(self.characters[i].weapon.healValue))", terminator: "")
                }
                print("")
            }
        }
        
        if action == .Attack {
            characCount = adversary.characters.count
        } else {
            characCount = self.characters.count
        }
        
        let numSelection = selectionFromUser()
        if numSelection > 0 {
            if numSelection >= 1 && numSelection <= characCount {
                switch action {
                case .Attack:
                    targetCharacter = adversary.characters[numSelection-1]
                    
                case .Heal:
                    targetCharacter = self.characters[numSelection-1]
                }
            } else {
                print("Veuillez entrer un numéro valide")
            }
        }
        
        return targetCharacter
    }
    
    // Recovery the value entered by the player
    private func selectionFromUser() -> Int {
        var numSelection = 0
        
        if let response = readLine() {
            if response.isStringAnInt {
                numSelection = Int(response)!
            }else{
                print("Veuillez entrer un numéro valide")
            }
        }
        
        return numSelection
    }
    
}
