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
    
    // Instance of player class
    var playerOne = Player(name: "Antoine")
    var playerTwo = Player(name: "Computer")
    
    // Loop of the game
    public func playGame() {
        var currentPlayer = playerOne
        var currentAdversary = playerTwo
        let box = Box()
        
        presentationTeam()
        chooseTeam()
        presentationGame()
        
        while currentPlayer.isAlive {
            if let selectedCharacter = currentPlayer.selectCharacter() {
                box.boxAppear(character: selectedCharacter)
                if let selectedTarget = currentPlayer.selectTarget(selection: selectedCharacter, adversary: currentAdversary) {
                    selectedCharacter.doAction(target: selectedTarget)
                    currentAdversary.updateTeam()
                    currentPlayer = switchPlayer(player: currentPlayer)
                    currentAdversary = switchPlayer(player: currentAdversary)
                }
            }
        }
        currentPlayer = switchPlayer(player: currentPlayer)
        displayWinner(winner: currentPlayer)
    }
    
    // Presentation to configure the team
    private func presentationTeam() {
        print("Avant de commencer la partie, vous allez devoir composer votre équipe.")
        print("Chaque équipe sera composé de 3 personnages.")
        print("Chaque joueur devra définir le type et le nom de chaque personnage.")
        print("Pour définir le type, vous devrez taper le numéro du type dans la liste qui apparaitra.", terminator: "\n\n")
    }
    
    // Configure each team player and computer
    private func chooseTeam() {
        
        for _ in 0...charactersMax-1 {
            choiceCharacterType(player: playerOne)
            choiceCharacterName(player: playerOne)
        }
        
        configureComputerTeam()
    }
    
    // Add 3 character to the computer team
    private func configureComputerTeam() {
        playerTwo.characters.append(Fighter())
        playerTwo.characters[0].name = "CombattantTwo"
        playerTwo.characters.append(Mage())
        playerTwo.characters[1].name = "MageTwo"
        playerTwo.characters.append(Dwarf())
        playerTwo.characters[2].name = "NainTwo"
    }

    // Choice the name of the character
    private func choiceCharacterType(player: Player) {
        print("\(player.name), choisit le type du personnage \(player.characters.count + 1) :")
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
            print("Veuillez entrer un numéro valide", terminator: "\n\n")
            
            choiceCharacterType(player: player)
        }
    }
    
    // Choice the name of the character
    private func choiceCharacterName(player: Player) {
        print("Veuillez entrer le nom du personnage \(player.characters.count)")
        
        if let response = readLine() {
            if response.characters.count > 0 && checkNameExisting(name: response) == false {
                player.characters[player.characters.count - 1].name = response
                player.characters[player.characters.count - 1].introduceYou()
                print("")
            } else {
                print("Le nom est non valide ou déjà utilisé")
                choiceCharacterName(player: player)
            }
        }
    }
    
    // Check if the name entered is already existing
    private func checkNameExisting(name: String) -> Bool {
        
        for character in playerOne.characters {
            if character.name == name {
                return true
            }
        }
        
        for character in playerTwo.characters {
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
        print("Pour choisir un personnage, vous devrez taper son numéro dans la liste qui apparaitra.", terminator: "\n\n")
    }
    
    // Switch the current player
    private func switchPlayer(player: Player) -> Player {
        if player.name == "Antoine" {
            numberOfTurn += 1
            return playerTwo
        }
        return playerOne
    }
    
    // Display the winner of the game
    private func displayWinner(winner: Player) {
        print("\(winner.name) gagne la partie en \(numberOfTurn) tours de jeu")
    }
}
