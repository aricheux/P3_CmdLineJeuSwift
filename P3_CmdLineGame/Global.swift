//
//  Global.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 09/08/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Define global class
class Global {
    
    // Recovery the value entered by the player / Function available for every other class  
    static func input() -> Int {
        var selectionNumber = 0
        
        if let response = readLine() {
            if let responseNumber = response.isStringAnInt {
                selectionNumber = responseNumber
            } else {
                print("Veuillez entrer un numéro valide")
                selectionNumber = input()
            }
        }
        
        return selectionNumber
    }
    
}
