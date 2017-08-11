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
    
    // Loop of the game
    public func playGame() {
        var currentPlayer = player1
        var currentAdversary = player2
        var selectedCharacter: Character
        var selectedTarget: Character
        
        howChooseTeam()
        chooseTeam()
        presentationGame()
        
        while currentPlayer.isAlive {
            selectedCharacter = currentPlayer.selectCharacter()
            boxAppear(character: selectedCharacter)
            selectedTarget = currentPlayer.selectTarget(selection: selectedCharacter, adversary: currentAdversary)
            selectedCharacter.doAction(target: selectedTarget)
            currentAdversary.updateTeam()
            currentPlayer = switchPlayer(player: currentPlayer)
            currentAdversary = switchPlayer(player: currentAdversary)
        }
        currentPlayer = switchPlayer(player: currentPlayer)
        displayWinner(winner: currentPlayer)
    }
    
    // Presentation to configure the team
    private func howChooseTeam() {
        print("Avant de commencer la partie, vous allez devoir composer votre équipe.")
        print("Chaque équipe sera composé de 3 personnages.")
        print("Chaque joueur devra définir le type et le nom de chaque personnage.")
        print("Pour définir le type, vous devrez taper le numéro du type dans la liste qui apparaitra.")
        print("Voici les différents types de personnage disponible et leurs caractéristiques:")
        print("---- Combattant : Vie(100) Dégat(10)")
        print("---- Mage : Vie(100) Soin(20)")
        print("---- Colosse : Vie(150) Dégat(5)")
        print("---- Nain : Vie(50) Dégat(30)")
        print("")
    }
    
    //
    private func chooseTeam() {
        configureTeam(player: player1)
        /*player1.characters.append(Fighter())
        player1.characters[0].name = "CombattantTwo"
        player1.characters.append(Mage())
        player1.characters[1].name = "MageTwo"
        player1.characters.append(Dwarf())
        player1.characters[2].name = "NainTwo"*/
        //configureTeam(player: player2)
        player2.characters.append(Fighter())
        player2.characters[0].name = "CombattantTwo"
        player2.characters.append(Mage())
        player2.characters[1].name = "MageTwo"
        player2.characters.append(Dwarf())
        player2.characters[2].name = "NainTwo"
    }
    
    // Configure the team of the player
    public func configureTeam(player: Player) {
        var iCharacters = 0
        
        while (iCharacters < charactersMax) {
            print("\(player.name), choisit le type du personnage \(iCharacters+1): ")
            print("1 - Combattant : Vie(100) Dégat(10)")
            print("2 - Mage : Vie(40) Soin(20)")
            print("3 - Colosse : Vie(150) Dégat(5)")
            print("4 - Nain : Vie(50) Dégat(30)")
            
            switch Global.input() {
            case 1:
                player.characters.append(Fighter())
            case 2:
                player.characters.append(Mage())
            case 3:
                player.characters.append(Colossus())
            case 4:
                player.characters.append(Dwarf())
            default:
                print("Veuillez entrer un numéro valide")
                configureTeam(player: player)
            }
            
            choiceCharacterName(player: player)
            iCharacters += 1
        }
    }
    
    // Choice the name of the character
    private func choiceCharacterName(player: Player) {
        print("Veuillez entrer le nom du personnage \(player.characters.count)")
        
        if let response = readLine() {
            if response.characters.count > 0 && checkNameExisting(name: response) == false {
                player.characters[player.characters.count-1].name = response
                player.characters[player.characters.count-1].introduceYou()
                print("")
            } else {
                print("Le nom est non valide ou déjà utilisé")
                choiceCharacterName(player: player)
            }
        }
    }
    
    // Check if the name entered is already existing
    private func checkNameExisting(name: String) -> Bool {
        
        for character in player1.characters {
            if character.name == name {
                return true
            }
        }
        
        for character in player2.characters {
            if character.name == name {
                return true
            }
        }
        
        return false
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
    
    // A random box appear
    private func boxAppear(character: Character) {
        let randomBoxValue = Int(arc4random_uniform(4))
        
        if randomBoxValue == 0 {
            print("* * * * * * * * * * * * * * * * * * * * * * * * * * * * *")
            switch BoxType(rawValue: Int(arc4random_uniform(3)))! {
            case .WeaponBox:
                weaponBox(selection: character)
            case .CareBox:
                careBox(selection: character)
            case .ArmorBox:
                armorBox(selection: character)
            }
            print("* * * * * * * * * * * * * * * * * * * * * * * * * * * * *")
            print("")
        }
    }
    
    // Open the weapon box and change the weapon if it's possible
    private func weaponBox(selection: Character) {
        let randomWeapon = Weapon()
        
        if let randomWeaponType = WeaponType(rawValue: Int(arc4random_uniform(1))) {
            randomWeapon.type = randomWeaponType
            print("une boite d'arme apparait (type: \(randomWeapon.type)", terminator: " ")
            
            switch randomWeapon.type {
            case .Damage:
                randomWeapon.damageValue = Int(arc4random_uniform(20)) + 30
                print("dégat: \(randomWeapon.damageValue))")
            case .Healing:
                randomWeapon.healValue = Int(arc4random_uniform(10)) + 20
                print("soin: \(randomWeapon.healValue))")
            }
            
            if selection.weapon.type == randomWeapon.type {
                selection.weapon = randomWeapon
                print("\(selection.name) s'équipe de la nouvelle arme")
            } else {
                print("\(selection.name) ne peux pas s'équiper de cette arme")
            }
        }
    }
    
    // Open the care box and add the life to the character
    private func careBox(selection: Character) {
        let careBoxValue = Int(arc4random_uniform(20)) + 10
        
        print("une boite de soin apparait (soin: \(careBoxValue))")
        selection.receveLife(life: careBoxValue)
    }
    
    // Open the armor box and add the armor to the character
    private func armorBox(selection: Character) {
        let armorBoxValue = Int(arc4random_uniform(20)) + 10
        
        print("Une boite d'armure apparait (armure: \(armorBoxValue))")
        selection.receveArmor(armor: armorBoxValue)
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
        print("\(winner.name) gagne la partie en \(numberOfTurn) tours de jeu")
    }
}
