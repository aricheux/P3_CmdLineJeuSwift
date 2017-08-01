//
//  Game.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 27/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Define the game class
class Game {
    // Maximum number of character per player
    let charactersMax = 3
    
    // Number of turn per game
    var numberOfTurn = 0
    
    // Number of player in game
    var playerNumber: Int
    
    // Instance of player class
    var player: [Player] = []
    
    // Initializes the new instance with property
    init(playerNumber: Int) {
        self.playerNumber = playerNumber
    }
    
    // Presentation of the game
    public func presentationGame() {
        print("La partie va commencer, voici son deroulement :")
        print("1, vous devrez choisir un personnage de votre équipe")
        print("2, vous devrez choisir vous aurez deux actions possible : attaquer ou soigner")
        print("Si vous attaquez, vous devrez choisir un personnage dans l'équipe adversaire à attaquer")
        print("Si vous soignez, vous devrez choisir un personnage dans votre équipe à soigner")
        print("Pour choisir un personnage, vous devrez taper son numéro dans la liste")
        print("")
    }
    
    // Presentation to configure the team
    public func presentationTeam() {
        print("Avant de commencer la partie, vous allez devoir composer votre équipe.")
        print("Chaque équipe sera composé de 3 personnages.")
        print("Chaque joueur devra définir le type et le nom de chaque personnage.")
        print("Pour définir le type, vous devrez taper son numéro dans la liste.")
        print("")
    }
    
    // Configure the team of the player
    public func configureTeam(player: Player) {
        var iCharacters = 0
        
        while (iCharacters < charactersMax) {
            print("\(player.name), choisit le type du personnage \(iCharacters+1): ", terminator: "")
            
            for i in 0...3 {
                if let characType = CharacterType(rawValue:i) {
                    print("[\(i+1)] -- \(characType)",terminator: " ")
                }
            }
            
            if player.choiceCharacterType() {
                print("Entrer le nom du personnage \(iCharacters+1): ")
                if choiceCharacterName(player: player) {
                    // Next character
                    iCharacters += 1
                }
            }
        }
    }
    // Play the game
    public func playGame() {
        var iAdversary = 1
        var iPlayer = 0 {
            didSet {
                if iPlayer == 0 {
                    iAdversary = 1
                } else {
                    iAdversary = 0
                }
            }
        }
        
        // Run the game until one of player have no character alive
        while self.player[0].checkCharactersAlive() && self.player[1].checkCharactersAlive() {
            
            if let characterSelection = self.player[iPlayer].selectCharacter() {
                weaponBox(selection: characterSelection)
                
                if let actionSelection = self.player[iPlayer].selectedAction(charactType: characterSelection.type) {
                    
                    if let targetSelection = self.player[iPlayer].selectedTarget(adversary : self.player[iAdversary], action : actionSelection) {
                        
                        executeAction(selection: characterSelection, target: targetSelection, action: actionSelection)
                        
                        iPlayer += 1
                        if iPlayer > self.playerNumber-1 {
                            iPlayer = 0
                            // Increase counter turn
                            self.numberOfTurn += 1
                        }
                        
                        print("")
                    }
                }
            }
        }
        if self.player[0].checkCharactersAlive() {
            print("\(self.player[0].name) à gagné la partie", terminator : " ")
        } else {
            print("\(self.player[1].name) à gagné la partie", terminator : " ")
        }
        print("en \(self.numberOfTurn) tours de combat")
    }
    
    // Open the weapon box and change the weapon if it's possible
    private func weaponBox(selection : Character) {
        let randomBoxValue: Int = Int(arc4random_uniform(5))
        let randowWeapon = Weapon()
        
        // Open the weapon box if it's the good number
        if randomBoxValue == 0 {
            randowWeapon.type = WeaponType(rawValue: Int(arc4random_uniform(1)))!
            print("****** Une boite d'arme apparait ***** ")
            print("")
            print("\(selection.name) ouvre une boite d'arme (type:\(randowWeapon.type)", terminator: " ")
            switch randowWeapon.type {
            case .Damage:
                randowWeapon.damageValue = Int(arc4random_uniform(20)) + 30
                print("dégat:\(randowWeapon.damageValue))")
            case .Healing:
                randowWeapon.healValue = Int(arc4random_uniform(10)) + 20
                print("soin:\(randowWeapon.healValue))")
            }
            if selection.weapon.type == randowWeapon.type {
                selection.weapon = randowWeapon
                print("\(selection.name) s'équipe de cette nouvelle arme")
            } else {
                print("\(selection.name) ne peux pas s'équiper de cette arme")
            }
            print("")
        }
    }
    
    // execute the action to the target
    private func executeAction(selection: Character, target: Character, action: actionType) {
        switch action {
        case .Attack:
            print("\(selection.name) attaque \(target.name)")
            target.life -= selection.weapon.damageValue
            
        case .Heal:
            print("\(selection.name) soigne \(target.name)")
            target.life += selection.weapon.healValue
        }
    }
    
    // Choice the name of the character
    private func choiceCharacterName(player: Player) -> Bool {
        var characterNameOk = false
        
        if let response = readLine() {
            if response.characters.count > 0 && (checkNameExisting(name: response) == false){
                    player.characters[player.characters.count-1].name = response
                    print("Personnage 1 : \(response) \(player.characters[player.characters.count-1].type)")
                    print("")
                    characterNameOk = true
            } else {
                print("Nom non valide ou déjà utilisé")
                let _ = choiceCharacterName(player: player)
            }
        }
        
        return characterNameOk
    }
    
    // Check if the name entered is already existing
    private func checkNameExisting(name: String) -> Bool {
        var iCharacter = 0
        var nameExisting = false
        
        for iPlayer in 0...playerNumber-1 {
            if nameExisting == false {
                while iCharacter < player[iPlayer].characters.count {
                    if (player[iPlayer].characters[iCharacter].name == name) {
                        nameExisting = true
                        break
                    } else {
                        iCharacter += 1
                    }
                }
            }
        }
        
        return nameExisting
    }
}
