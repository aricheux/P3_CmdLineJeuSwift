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

class Game{
    var playerNb : Int
    let charactersMax = 3
    var player : [Player] = []
    
    init(playerNb: Int){
        self.playerNb = playerNb
        self.player.append(Player(name: "Antoine"))
        self.player.append(Player(name: "Kevin"))
        
        // to delete
        self.player[0].characters.append(Character(type: .colossus, name:"tank 1"))
        self.player[0].characters.append(Character(type: .mage, name:"heal 1"))
        self.player[0].characters.append(Character(type: .dwarf, name:"nain 1"))
        self.player[1].characters.append(Character(type: .colossus, name:"tank 2"))
        self.player[1].characters.append(Character(type: .mage, name:"heal 2"))
        self.player[1].characters.append(Character(type: .dwarf, name:"nain 2"))
    }
    
    // Starting the game
    public func playGame(){
        while self.player[0].characters.count
    }
    // The player select who use
    private func selectedCharacter(){
        
    }
    // the player select the action to do
    private func selectedAction(){
        
    }
    // the player select the target
    private func selectedTarget(){
        
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
