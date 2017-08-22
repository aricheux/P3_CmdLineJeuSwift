//
//  String.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 20/08/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Add a function to check if the entered string is a number
extension String {
    var isStringAnInt: Int? {
        if Int(self) != nil {
            return Int(self)
        }
        return nil
    }
}
