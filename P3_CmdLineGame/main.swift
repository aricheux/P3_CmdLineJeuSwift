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

game.presentationTeam()
game.configureTeam(player: game.player[0])

// ******* to delete ********
/*game.player[0].characters.append(Fighter())
game.player[0].characters[0].name = "CombattantOne"
game.player[0].characters.append(Mage())
game.player[0].characters[1].name = "MageOne"
game.player[0].characters.append(Dwarf())
game.player[0].characters[2].name = "NainOne"*/
game.player[1].characters.append(Fighter())
game.player[1].characters[0].name = "CombattantTwo"
game.player[1].characters.append(Mage())
game.player[1].characters[1].name = "MageTwo"
game.player[1].characters.append(Dwarf())
game.player[1].characters[2].name = "NainTwo"
// **************************


game.presentationGame()
game.playGame()

