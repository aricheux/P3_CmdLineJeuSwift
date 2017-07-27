//
//  Game.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 27/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

enum actionType : Int{
    case attack, heal
}

enum enum_stepAction{
    case selectedCharacter, selectedAction, selectedTarget, executeAction
}

class Game{
    var playerNumber : Int
    let charactersMax = 3
    var player : [Player] = []
    
    init(playerNumber: Int){
        self.playerNumber = playerNumber
    }
    
    // Starting the game
    public func playGame(){
        var iPlayer = 0
        var stepAction : enum_stepAction = .selectedCharacter
        var characterSelection : Character?
        var actionSelection : actionType?
        var targetSelection : Character?
        
        // Run the game until one of player have no character alive
        while self.player[0].checkCharactersAlive() && self.player[1].checkCharactersAlive() {
            switch stepAction {
            case .selectedCharacter:
                characterSelection = selectedCharacter(player : self.player[iPlayer])
                if characterSelection != nil{
                    // Next step
                    stepAction = .selectedAction
                }
            case .selectedAction:
                actionSelection = selectedAction(player : self.player[iPlayer])
                if actionSelection != nil{
                    // Next step
                    stepAction = .selectedAction
                }
            case .selectedTarget:
                targetSelection = selectedTarget(player : self.player[iPlayer])
                if targetSelection != nil{
                    // Next step
                    stepAction = .executeAction
                }
            case .executeAction:
                // Next player
                iPlayer += 1
                if iPlayer > self.playerNumber-1{
                    iPlayer = 0
                }
                // Next step
                stepAction = .selectedCharacter
            }
        }
    }
    // the player select who use
    private func selectedCharacter(player : Player) -> Character? {
        return nil
    }
    // the player select the action to do
    private func selectedAction(player : Player) -> actionType?{
        return nil
    }
    // the player select the target
    private func selectedTarget(player : Player) -> Character? {
        return nil
    }
    // execute the action to the target
    private func executeAction(selection : Character, target : Character, type : actionType) -> Bool{
        return true
    }
    // Configure the team of the player
    public func configureTeam(player : Player) {
        print("****** A toi \(player.name), choisit tes 3 personnages ******")
        var iCharacters = 0
        // Create character of the team
        while (iCharacters < charactersMax) {
            // Choice the type of the character
            print("Type du personnage \(iCharacters+1) : 1.Combattant 2.Mage 3.Colosse 4.Nain")
            if choiceCharacterType(player: player){
                // Choice the name of the character
                print("Entrer le nom du personnage \(iCharacters+1) :")
                if choiceCharacterName(player: player){
                    // Next character
                    iCharacters += 1
                }
            }
        }
        showTeamStatus(player: player)
    }
    // Choice the type of the character
    private func choiceCharacterType(player : Player) -> Bool{
        var characterTypeOk = false
        // Wait the entered value
        if let response = readLine(){
            // Check if the input is an integer valude
            if isStringAnInt(string: response){
                // convert to integer value
                let numType = Int(response)!
                // Add a new character according to the input value
                switch numType {
                case 1...4:
                    // Add new character
                    // subtract 1 to match with the enumeration
                    player.characters.append(Character(type: characterType(rawValue: numType-1)!, name:"Character"))
                    // function ok
                    characterTypeOk = true
                default:
                    print("Veuillez entrer un numéro valide")
                }
            }else{
                print("Veuillez entrer un numéro valide")
            }
        }
        return characterTypeOk
    }
    // Choice the name of the character
    private func choiceCharacterName(player : Player) -> Bool{
        var characterNameOk = false
        
        while characterNameOk == false{
            // Wait the entered value
            if let response = readLine(){
                if response.characters.count > 0{
                    // check if the name is already use
                    if (checkNameExisting(name: response) == false){
                        // Change the character name by the name entered
                        player.characters[player.characters.count-1].name = response
                        // function is a success
                        characterNameOk = true
                    }else{
                        print("Le nom est déjà utilisé, veuillez entrer un autre nom")
                    }
                }else{
                    print("Veuillez entrer un nom valide (minimum 1 charactères)")
                }
            }
        }
        return characterNameOk
    }
    // Show the actual status of the team
    private func showTeamStatus(player : Player) {
        print("Equipe de \(player.name) : ")
        for i in 0...player.characters.count-1{
            print("\(player.characters[i].name) : \(player.characters[i].type)"
                + " vie(\(player.characters[i].life))",terminator: " ")
            switch player.characters[i].type{
            case .mage:
                print("soin(\(player.characters[i].weapon.healing))")
            default:
                print("dégat(\(player.characters[i].weapon.damage))")
            }
            
        }
        print("\n")
    }
    // Check if the name entered is already existing
    private func checkNameExisting(name : String) -> Bool{
        var iCharacter = 0
        var nameExisting = false
        
        for iPlayer in 0...playerNb-1{
            // do not continue to the next player if we have already an existing name
            if nameExisting == false{
                // check if the name is already use
                while iCharacter < player[iPlayer].characters.count{
                    if (player[iPlayer].characters[iCharacter].name == name){
                        // name already existing
                        nameExisting = true
                        // do not continue
                        break
                    }else{
                        iCharacter += 1
                    }
                }
            }
        }
        return nameExisting
    }
    // Check if the entered value is an integer value
    private func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }
    
}
