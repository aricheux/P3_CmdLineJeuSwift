//
//  ViewController.swift
//  P3_JeuRole
//
//  Created by RICHEUX Antoine on 26/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//
import Foundation

// ENUMERATION
enum characterType : Int {
    case fighter, mage, colossus, dwarf
}

enum weaponType : Int{
    case attack, heal
}

// Character class
class Character {
    var name : String
    var life : Int
    var type : characterType
    var weapon : Weapon
    
    init(type: characterType, name :String){
        self.type = type
        self.name = name
        
        // Define feature according to the type of character
        switch type {
        case .fighter:
            self.life = 100
            self.weapon = Weapon(type: .attack, damage: 10, healing : 0)
        case .mage:
            self.life = 50
            self.weapon = Weapon(type: .attack, damage: 0, healing : 20)
        case .colossus:
            self.life = 200
            self.weapon = Weapon(type: .attack, damage: 5, healing : 0)
        case .dwarf:
            self.life = 40
            self.weapon = Weapon(type: .attack, damage: 30, healing : 0)
        }
    }
}
// Weapon class
class Weapon{
    var damage : Int
    var healing : Int
    var type : weaponType
    
    init(type: weaponType, damage: Int, healing: Int) {
        self.damage = damage
        self.type = type
        self.healing = healing
    }
}
// Player class
class Player{
    var name : String
    var characters : [Character] = []
    
    init(name : String){
        self.name = name
    }
    
}
class Game{
    var playerNb : Int
    let charactersMax = 3
    var player : [Player] = []
    
    init(playerNb: Int){
        self.playerNb = playerNb
        self.player.append(Player(name: "Antoine"))
        self.player.append(Player(name: "Kevin"))
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
                    player.characters.append(Character(type: characterType(rawValue: numType-1)!, name: "Warrior"))
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


// Create the game
let game = Game(playerNb: 2)

//
for iPlayer in 0...game.playerNb-1{
    game.configureTeam(player: game.player[iPlayer])
}

