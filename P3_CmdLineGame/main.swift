//
//  ViewController.swift
//  P3_JeuRole
//
//  Created by RICHEUX Antoine on 26/07/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//
import Foundation

// Create the game
let game = Game()

//game.configureTeam(player: game.player[0])

// ******* to delete ********
game.player1.characters.append(Fighter())
game.player1.characters[0].name = "CombattantOne"
game.player1.characters.append(Mage())
game.player1.characters[1].name = "MageOne"
game.player1.characters.append(Dwarf())
game.player1.characters[2].name = "NainOne"
game.player2.characters.append(Fighter())
game.player2.characters[0].name = "CombattantTwo"
game.player2.characters.append(Mage())
game.player2.characters[1].name = "MageTwo"
game.player2.characters.append(Dwarf())
game.player2.characters[2].name = "NainTwo"
// **************************

game.playGame()

