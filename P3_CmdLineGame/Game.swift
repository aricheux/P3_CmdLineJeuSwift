//
//  Game.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 27/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

extension Int {
    var boolValue: Bool {
        if self == 0 {
            return false
        } else {
            return true
        }
    }
}

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
                showTeamStatus(player: self.player[iPlayer])
                characterSelection = selectedCharacter(player : self.player[iPlayer])
                if characterSelection != nil{
                    // Next step
                    stepAction = .selectedAction
                }
            case .selectedAction:
                // Choice the action only if it's a mage
                if characterSelection!.type == .mage {
                    actionSelection = selectedAction(player : self.player[iPlayer])
                }else{
                    actionSelection = .attack
                }
                if actionSelection != nil{
                    // Next step
                    stepAction = .selectedTarget
                }
            case .selectedTarget:
                var iAdversary : Int
                if iPlayer == 0{
                    iAdversary = 1
                }else{
                    iAdversary = 0
                }
                targetSelection = selectedTarget(player : self.player[iPlayer], adversary : self.player[iAdversary], action : actionSelection!)
                if targetSelection != nil{
                    // Next step
                    stepAction = .executeAction
                }
            case .executeAction:
                executeAction(selection: characterSelection!, target: targetSelection!, action: actionSelection!)
                // Next player
                iPlayer += 1
                if iPlayer > self.playerNumber-1{
                    iPlayer = 0
                }
                print("")
                // Next step
                stepAction = .selectedCharacter
            }
        }
        print("La partie est finie")
    }
    // the player select who use
    private func selectedCharacter(player : Player) -> Character? {
        var selectedCharacter : Character?
        
        print("Choisir un personnage :",terminator: " ")
        for i in 0...player.characters.count-1{
            print("\(i+1).\(player.characters[i].name)",terminator: " ")
        }
        // Recovery the value entered by the player
        let numSelection = selectionFromUser()
        if numSelection > 0 {
            switch numSelection {
            case 1...charactersMax:
                selectedCharacter = player.characters[numSelection-1]
            default:
                print("Veuillez entrer un numéro valide")
            }
        }
        return selectedCharacter
    }
    // the player select the action to do
    private func selectedAction(player : Player) -> actionType?{
        var selectedAction : actionType?
        
        print("Que voulez vous faire : 1. Attaquer 2.Soigner")
        // Recovery the value entered by the player
        let numSelection = selectionFromUser()
        if numSelection > 0 {
            switch numSelection {
            case 1...2:
                selectedAction = actionType(rawValue: numSelection-1)
            default:
                print("Veuillez entrer un numéro valide")
            }
        }
        return selectedAction
    }
    // the player select the target
    private func selectedTarget(player : Player, adversary: Player, action : actionType) -> Character? {
        var targetCharacter : Character?
        
        switch action {
        case .attack:
            print("Qui attaquer :",terminator: " ")
            for i in 0...adversary.characters.count-1{
                print("\(i+1).\(adversary.characters[i].name)",terminator: " ")
            }
            
        case .heal:
            print("Qui soigner :",terminator: " ")
            for i in 0...player.characters.count-1{
                print("\(i+1).\(player.characters[i].name)",terminator: " ")
            }
        }
        // Recovery the value entered by the player
        let numSelection = selectionFromUser()
        if numSelection > 0 {
            switch numSelection {
            case 1...charactersMax:
                // Define the target according to the action and selection
                switch action {
                case .attack:
                    targetCharacter = adversary.characters[numSelection-1]
                    
                case .heal:
                    targetCharacter = player.characters[numSelection-1]
                }
            default:
                print("Veuillez entrer un numéro valide")
            }
            
        }
        return targetCharacter
    }
    // execute the action to the target
    private func executeAction(selection : Character, target : Character, action : actionType){
        switch action {
        case .attack:
            print("\(selection.name) attaque \(target.name)")
            target.life -= selection.weapon.damageValue
            
        case .heal:
            print("\(selection.name) soigne \(target.name)")
            target.life += selection.weapon.healValue
        }
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
        // Recovery the value entered by the player
        let numSelection = selectionFromUser()
        if numSelection > 0 {
            // Add a new character according to the input value
            switch numSelection {
            case 1...4:
                // Add new character
                // subtract 1 to match with the enumeration
                player.characters.append(Character(type: characterType(rawValue: numSelection-1)!, name:"Character"))
                // function ok
                characterTypeOk = true
            default:
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
                + " vie(\(player.characters[i].life))"
                + " dégat(\(player.characters[i].weapon.damageValue))", terminator: "")
            if player.characters[i].type == .mage{
                print(" soin(\(player.characters[i].weapon.healValue))", terminator: "")
            }
            print("")
        }
    }
    // Check if the name entered is already existing
    private func checkNameExisting(name : String) -> Bool{
        var iCharacter = 0
        var nameExisting = false
        
        for iPlayer in 0...playerNumber-1{
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
    
    // Recovery the value entered by the player
    private func selectionFromUser() -> Int{
        var numSelection = 0
        // Wait the entered value
        if let response = readLine(){
            // Check if the input is an integer valude
            if isStringAnInt(string: response){
                // convert to integer value
                numSelection = Int(response)!
            }else{
                print("Veuillez entrer un numéro valide")
            }
        }
        return numSelection
    }
    
}
