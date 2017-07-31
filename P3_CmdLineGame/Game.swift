//
//  Game.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 27/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Define the step of the game
enum StepAction{
    case selectedCharacter
    case weaponBox
    case selectedAction
    case selectedTarget
    case executeAction
}

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
    // Presentation of the game
    public func presentationTeam() {
        print("Avant de commencer la partie, vous allez devoir composer votre équipe.")
        print("Chaque équipe sera composé de 3 personnages.")
        print("Chaque joueur devra définir le type et le nom de chaque personnage.")
        print("Pour définir le type, vous devrez taper son numéro dans la liste.")
        print("")
    }
    // Configure the team of the player
    public func configureTeam(player : Player) {
        var iCharacters = 0
        while (iCharacters < charactersMax) {
            print("\(player.name), choisit le type du personnage \(iCharacters+1): ", terminator: "")
            for i in 0...CharacterType.count-1 {
                print("[\(i+1)] -- \(CharacterType(rawValue:i)!)",terminator: " ")
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
        var iPlayer = 0
        
        var stepAction: StepAction = .selectedCharacter
        
        var characterSelection: Character?
        
        var actionSelection: actionType?
        
        var targetSelection: Character?
        
        // Run the game until one of player have no character alive
        while self.player[0].checkCharactersAlive() && self.player[1].checkCharactersAlive() {
            switch stepAction {
            case .selectedCharacter:
                self.player[iPlayer].showTeamStatus()
                characterSelection = self.player[iPlayer].selectCharacter()
                if characterSelection != nil {
                    // Generate a randow box
                    let randomBoxValue : Int = Int(arc4random_uniform(3))
                    // Open the weapon box if it's the good number
                    if randomBoxValue == 0 {
                        // Next step
                        stepAction = .weaponBox
                    } else {
                        // Next step
                        stepAction = .selectedAction
                    }
                }
            case .weaponBox:
                // Open the weapon box
                openWeaponBox(selection: characterSelection!)
                // Next step
                stepAction = .selectedAction
            case .selectedAction:
                // Choice the action only if it's a mage
                if characterSelection!.type == .mage {
                    actionSelection = self.player[iPlayer].selectedAction()
                } else {
                    actionSelection = .attack
                }
                if actionSelection != nil {
                    // Next step
                    stepAction = .selectedTarget
                }
            case .selectedTarget:
                // Define the index for the adversary
                var iAdversary: Int
                if iPlayer == 0 {
                    iAdversary = 1
                } else {
                    iAdversary = 0
                }
                // Define the target
                targetSelection = selectedTarget(player : self.player[iPlayer], adversary : self.player[iAdversary], action : actionSelection!)
                if targetSelection != nil {
                    // Next step
                    stepAction = .executeAction
                }
            case .executeAction:
                executeAction(selection: characterSelection!, target: targetSelection!, action: actionSelection!)
                // Next player
                iPlayer += 1
                if iPlayer > self.playerNumber-1 {
                    iPlayer = 0
                    // Increase counter turn
                    self.numberOfTurn += 1
                }
                print("")
                // Next step
                stepAction = .selectedCharacter
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
    private func openWeaponBox(selection : Character) {
        
        let randowWeapon = Weapon()
        
        randowWeapon.type = WeaponType(rawValue: Int(arc4random_uniform(1)))!
        print("****** Une boite d'arme apparait ***** ")
        print("")
        print("\(selection.name) ouvre une boite d'arme (type:\(randowWeapon.type)", terminator: " ")
        switch randowWeapon.type {
        case .damage:
            randowWeapon.damageValue = Int(arc4random_uniform(20)) + 30
            print("dégat:\(randowWeapon.damageValue))")
        case .healing:
            randowWeapon.healValue = Int(arc4random_uniform(10)) + 20
            print("soin:\(randowWeapon.healValue))")
        }
        if selection.weapon.type == randowWeapon.type {
            selection.weapon = randowWeapon
            print("\(selection.name) s'équipe de cette nouvelle arme")
        }else{
            print("\(selection.name) ne peux pas s'équiper de cette arme")
        }
    }

    // the player select the target
    private func selectedTarget(player : Player, adversary: Player, action : actionType) -> Character? {
        var targetCharacter: Character?
        
        switch action {
        case .attack:
            print("Choisissez qui attaquer dans l'équipe de \(adversary.name) :",terminator: " ")
            for i in 0...adversary.characters.count-1 {
                print("\(i+1).\(adversary.characters[i].name) (\(adversary.characters[i].life))",terminator: " ")
            }
            
        case .heal:
            print("Choisissez qui soigner dans votre équipe :",terminator: " ")
            for i in 0...player.characters.count-1 {
                print("\(i+1).\(player.characters[i].name) (\(player.characters[i].life))",terminator: " ")
            }
        }
        // Define limite for the switch below, because each team don't have the same character
        var limitSwitch: Int
        
        if action == .attack {
            limitSwitch = adversary.characters.count
        } else {
            limitSwitch = player.characters.count
        }
        // Recovery the value entered by the player
        let numSelection = player.selectionFromUser()
        if numSelection > 0 {
            switch numSelection {
            case 1...limitSwitch:
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
    private func executeAction(selection : Character, target : Character, action : actionType) {
        switch action {
        case .attack:
            print("\(selection.name) attaque \(target.name)")
            target.life -= selection.weapon.damageValue
            
        case .heal:
            print("\(selection.name) soigne \(target.name)")
            target.life += selection.weapon.healValue
        }
    }
    
    // Choice the name of the character
    private func choiceCharacterName(player : Player) -> Bool {
        var characterNameOk = false
        
        while characterNameOk == false {
            if let response = readLine(){
                if response.characters.count > 0 {
                    if (checkNameExisting(name: response) == false) {
                        player.characters[player.characters.count-1].name = response
                        print("Personnage 1 : \(response) \(player.characters[player.characters.count-1].type)")
                        print("")
                        characterNameOk = true
                    } else {
                        print("Le nom est déjà utilisé, veuillez entrer un autre nom")
                    }
                } else {
                    print("Veuillez entrer un nom valide (minimum 1 charactères)")
                }
            }
        }
        return characterNameOk
    }
    // Check if the name entered is already existing
    private func checkNameExisting(name : String) -> Bool {
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
