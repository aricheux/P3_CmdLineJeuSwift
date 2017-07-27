//
//  ViewController.swift
//  P3_JeuRole
//
//  Created by RICHEUX Antoine on 26/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//
import Foundation

// Create the game
let game = Game(playerNb: 2)
game.player.append(Player(name: "Antoine"))
game.player.append(Player(name: "Kevin"))

// to delete

game.player[0].characters.append(Character(type: .colossus, name:"tank 1"))
game.player[0].characters.append(Character(type: .mage, name:"heal 1"))
game.player[0].characters.append(Character(type: .dwarf, name:"nain 1"))
game.player[1].characters.append(Character(type: .colossus, name:"tank 2"))
game.player[1].characters.append(Character(type: .mage, name:"heal 2"))
game.player[1].characters.append(Character(type: .dwarf, name:"nain 2"))

for iPlayer in 0...game.playerNb-1{
    //game.configureTeam(player: game.player[iPlayer])
}

game.player[0].characters[0].life -= 10

