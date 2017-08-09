//
//  Game.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 27/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

enum BoxType: Int {
    case WeaponBox
    case CareBox
    case ArmorBox
}

// Define the game class
class Game {
    // Maximum number of character per player
    let charactersMax = 3
    
    // Number of turn per game
    var numberOfTurn = 0
    
    // Instance of player class
    var player1 = Player(name: "Antoine")
    var player2 = Player(name: "Computer")
    
    public func playGame() {
        var currentPlayer = player1
        var currentAdversary = player2
        var selectedTarget: Character
        
        /*presentationTeam()
        chooseTeam()*/
        presentationGame()
        
        while currentPlayer.isAlive {
            let selectedCharacter = currentPlayer.selectCharacter()
            boxAppear(character: selectedCharacter)
            selectedCharacter.chooseAction()
            selectedTarget = currentPlayer.selectTarget(selection: selectedCharacter, adversary: currentAdversary)
            selectedCharacter.doAction(target: selectedTarget)
            updateTeam()
            currentPlayer = switchPlayer(player: currentPlayer)
            currentAdversary = switchPlayer(player: currentAdversary)
        }
        currentPlayer = switchPlayer(player: currentPlayer)
        displayWinner(winner: currentPlayer)
    }
    
    // Presentation to configure the team
    private func presentationTeam() {
        print("Avant de commencer la partie, vous allez devoir composer votre équipe.")
        print("Chaque équipe sera composé de 3 personnages.")
        print("Chaque joueur devra définir le type et le nom de chaque personnage.")
        print("Pour définir le type, vous devrez taper le numéro du type dans la liste qui apparaitra.")
        print("Voici les différents types de personnage disponible et leurs caractéristiques:")
        print("---- Figther : Dégat(10) Vie(100)")
        print("---- Mage : Dégat(20) Vie(100) Soin(20)")
        print("---- Colossus : Dégat(5) Vie(150)")
        print("---- Dwarf : Dégat(30) Vie(50)")
        print("")
    }
    
    private func chooseTeam() {
        configureTeam(player: player1)
        configureTeam(player: player2)
    }
    
    // Configure the team of the player
    public func configureTeam(player: Player) {
        let iCharacters = 0
        
        while (iCharacters < charactersMax) {
            print("\(player.name), choisit le type du personnage \(iCharacters+1): ", terminator: "")
            
            for i in 0...3 {
                if let characType = CharacterType(rawValue:i) {
                    print("[\(i+1)] -- \(characType)",terminator: " ")
                }
            }
            
            /*if player.choiceCharacterType() {
             print("Entrer le nom du personnage \(iCharacters+1): ")
             if choiceCharacterName(player: player) {
             // Next character
             iCharacters += 1
             }
             }*/
        }
    }
    
    // Presentation of the game
    public func presentationGame() {
        print("La partie va commencer, voici son deroulement :")
        print("1, vous devrez choisir un personnage de votre équipe.")
        print("2, vous devrez choisir vous aurez deux actions possible : attaquer ou soigner.")
        print("Si vous attaquez, vous devrez choisir un personnage dans l'équipe adversaire à attaquer.")
        print("Si vous soignez, vous devrez choisir un personnage dans votre équipe à soigner.")
        print("Pour choisir un personnage, vous devrez taper son numéro dans la liste qui apparaitra.")
        print("")
    }
    
    private func boxAppear(character: Character) {
        let randomBoxValue = Int(arc4random_uniform(4))
        
        if randomBoxValue == 0 {
            switch BoxType(rawValue: Int(arc4random_uniform(3)))! {
            case .WeaponBox:
                weaponBox(selection: character)
            case .CareBox:
                careBox(selection: character)
            case .ArmorBox:
                armorBox(selection: character)
            }
        }
    }
    
    // Open the weapon box and change the weapon if it's possible
    private func weaponBox(selection: Character) {
        let randomWeapon = Weapon()
        
        if let randomWeaponType = WeaponType(rawValue: Int(arc4random_uniform(1))) {
            randomWeapon.type = randomWeaponType
            print("****** Une boite d'arme apparait ***** ")
            print("\(selection.name) ouvre la boite d'arme (type:\(randomWeapon.type)", terminator: " ")
            
            switch randomWeapon.type {
            case .Damage:
                randomWeapon.damageValue = Int(arc4random_uniform(20)) + 30
                print("dégat:\(randomWeapon.damageValue))")
            case .Healing:
                randomWeapon.healValue = Int(arc4random_uniform(10)) + 20
                print("soin:\(randomWeapon.healValue))")
            }
            
            if selection.weapon.type == randomWeapon.type {
                selection.weapon = randomWeapon
                print("\(selection.name) s'équipe de la nouvelle arme")
            } else {
                print("\(selection.name) ne peux pas s'équiper de cette arme")
            }
        }
        print("")
    }
    
    // Open the care box and add the life to the character
    private func careBox(selection: Character) {
        let careBoxValue = Int(arc4random_uniform(20)) + 10
        
        print("****** Une boite de soin apparait *****")
        print("\(selection.name) ouvre la boite de soin (soin:\(careBoxValue))")
        selection.life += careBoxValue
    }
    
    // Open the armor box and add the armor to the character
    private func armorBox(selection: Character) {
        let armorBoxValue = Int(arc4random_uniform(20)) + 10
        
        print("****** Une boite d'armure apparait ***** ")
        print("\(selection.name) ouvre la boite d'armure (armure:\(armorBoxValue))")
        selection.armor += armorBoxValue
    }
    
    // Update all data on the team
    private func updateTeam() {
        
    }
    
    // Switch the current player
    private func switchPlayer(player: Player) -> Player {
        if player.name == "Antoine" {
            numberOfTurn += 1
            return player2
        }
        return player1
    }
    
    // Display the winner of the game
    private func displayWinner(winner: Player) {
        print("\(winner.name) gagne en \(numberOfTurn) tours de jeu")
    }
    
    // Choice the name of the character
    private func choiceCharacterName(player: Player) -> Bool {
        var characterNameOk = false
        
        if let response = readLine() {
            if response.characters.count > 0 && (checkNameExisting(name: response) == false){
                player.characters[player.characters.count-1].name = response
                print("Personnage 1 : \(response) \(player.characters[player.characters.count-1].typeName)")
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
        var iCharacter: Int
        
        for _ in 0...1 {
            iCharacter = 0
            while iCharacter < player1.characters.count {
                if (player1.characters[iCharacter].name == name) {
                    return true
                } else {
                    iCharacter += 1
                }
            }
        }
        
        return false
    }
}
