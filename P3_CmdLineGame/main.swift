//
//  ViewController.swift
//  P3_JeuRole
//
//  Created by RICHEUX Antoine on 26/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//
import Foundation

// Create the game
let game = Game(playerNumber: 2)
game.player.append(Player(name: "Antoine"))
game.player.append(Player(name: "Kevin"))

// to delete
game.player[0].characters.append(Character(type: .colossus, name:"tank_1"))
game.player[0].characters.append(Character(type: .mage, name:"heal_1"))
game.player[0].characters.append(Character(type: .dwarf, name:"nain_1"))
game.player[1].characters.append(Character(type: .colossus, name:"tank_2"))
game.player[1].characters.append(Character(type: .mage, name:"heal_2"))
game.player[1].characters.append(Character(type: .dwarf, name:"nain_2"))

game.playGame()

