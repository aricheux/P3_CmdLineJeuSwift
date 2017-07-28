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
/*game.player[0].characters.append(Character(type: .fighter, name:"war-1"))
game.player[0].characters.append(Character(type: .mage, name:"heal-1"))
game.player[0].characters.append(Character(type: .dwarf, name:"nain-1"))*/
game.player[1].characters.append(Character(type: .fighter, name:"war-2"))
game.player[1].characters.append(Character(type: .mage, name:"heal-2"))
game.player[1].characters.append(Character(type: .dwarf, name:"nain-2"))
game.configureTeam(player: game.player[0])
game.playGame()

