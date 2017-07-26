//
//  ViewController.swift
//  P3_JeuRole
//
//  Created by RICHEUX Antoine on 26/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//
import Foundation

// ENUMERATION
enum characterType {
    case fighter
    case mage
    case colossus
    case dwarf
}

enum weaponType{
    case attack
    case heal
}

// CLASSE
class Player{
    var name : String
    var characters : [Character] = []
    let charactersMax:Int = 3
    
    init(name : String){
        self.name = name
    }
    
    func choiceCharacter() {
        print("Choisir le type du personnage 1 :"
            + "\n1. Combattant 2. Mage 3. Colosse 4. Nain")
        // Wait the input value
        if let response = readLine(){
            let numType = Int(response)!
            // Add a new character according to the input value
            switch numType {
            case 1:
                self.characters.append(Character(type: .fighter, name: "Warrior"))
            case 2:
                self.characters.append(Character(type: .mage, name: "Heal"))
            case 3:
                self.characters.append(Character(type: .colossus, name: "Tank"))
            case 4:
                self.characters.append(Character(type: .dwarf, name: "Nain"))
            default:
                print("Entrée non valide")
            }
            print("vous avez \(numType)")
        }
    }
    
    func showStatusTeam() {
        print("Equipe de \(self.name) : ")
        for i in 0...self.characters.count-1{
            print("\(i+1).\(self.characters[i].type) (vie:\(self.characters[i].life) / dégat:\(self.characters[i].weapon.damage))")
        }
        
    }
}

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

let player_1 = Player(name: "Antoine")
player_1.choiceCharacter()
