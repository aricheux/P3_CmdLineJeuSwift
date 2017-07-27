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

// CLASSE
class Character {
    var name : String
    var life : Int
    var type : characterType
    var weapon : Weapon
    
    init(type: characterType, name :String){
        self.type = type
        self.name = name
        
        switch type {
        case .fighter:
            self.life = 100
            self.weapon = Weapon(type: .attack, damage: 10)
            
        case .mage:
            self.life = 50
            self.weapon = Weapon(type: .attack, damage: 20)
            
        case .colossus:
            self.life = 200
            self.weapon = Weapon(type: .attack, damage: 5)
            
        case .dwarf:
            self.life = 40
            self.weapon = Weapon(type: .attack, damage: 30)
        }
    }
}

class Weapon{
    var damage : Int
    var type : weaponType
    
    init(type: weaponType, damage: Int) {
        self.damage = damage
        self.type = type
    }
}

class Player{
    var name : String
    var characters : [Character] = []
    let charactersMax:Int = 3
    
    init(name : String){
        self.name = name
    }
    
    public func choiceCharacter() {
        print("********** A toi \(self.name), choisit ton équipe **********")
        var iCharacters = 0
        //
        while (iCharacters < charactersMax) {
            // Choice the type of the character
            print("Type du personnage \(iCharacters+1) : 1. Combattant 2. Mage 3. Colosse 4. Nain")
            if choiceCharacterType(){
                // Choice the type of the character
                print("Entrer le nom du personnage \(iCharacters+1) :")
                if choiceCharacterName(){
                    // Next character
                    iCharacters += 1
                }
            }
        }
    }
    
    public func showTeamStatus() {
        print("Equipe de \(self.name) : ")
        for i in 0...self.characters.count-1{
            print("\(i+1).\(self.characters[i].type) (vie:\(self.characters[i].life) / dégat:\(self.characters[i].weapon.damage))")
        }
        print("\n")
    }
    
    private func choiceCharacterType() -> Bool{
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
                    self.characters.append(Character(type: characterType(rawValue: numType-1)!, name: "Warrior"))
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
    
    private func choiceCharacterName() -> Bool{
        var characterNameOk = false
        
        while characterNameOk == false{
            // Wait the entered value
            if let response = readLine(){
                if response.characters.count > 0{
                    // Change the character name by the name entered
                    self.characters[self.characters.count-1].name = response
                    // function Ok
                    characterNameOk = true
                }else{
                    print("Veuillez entrer un nom valide (minimum 1 charactères)")
                }
            }
        }
        return characterNameOk
    }
    
    private func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }
}

let player_1 = Player(name: "Antoine")
let player_2 = Player(name: "Kevin")

//
player_1.choiceCharacter()
player_1.showTeamStatus()
//
player_2.choiceCharacter()
//player_2.showTeamStatus()
