//
//  Box.swift
//  P3_CmdLineGame
//
//  Created by RICHEUX Antoine on 15/08/2017.
//  Copyright © 2017 Richeux Antoine. All rights reserved.
//

import Foundation

// Define all type of box available
enum BoxType: Int {
    case WeaponBox
    case CareBox
    case ArmorBox
}

// Define the class box
class Box {
    
    // A box appaear randomly and open it depending of the type
    public func boxAppear(character: Character) {
        let randomBoxValue = Int(arc4random_uniform(3))

        if randomBoxValue == 0 {
            print("* * * * * * * * * * * * * * * * * * * * * * * * * * * * *")
            if let boxType = BoxType(rawValue: Int(arc4random_uniform(3))) {
                switch boxType {
                case .WeaponBox:
                    openWeaponBox(selection: character)
                case .CareBox:
                    openCareBox(selection: character)
                case .ArmorBox:
                    openArmorBox(selection: character)
                }
            }
            
            print("* * * * * * * * * * * * * * * * * * * * * * * * * * * * *", terminator: "\n\n")
        }
    }
    
    // Open the weapon box and change the weapon if it's possible
    private func openWeaponBox(selection: Character) {
        let randomWeapon = Weapon()
        
        if let randomWeaponType = WeaponType(rawValue: Int(arc4random_uniform(1))) {
            randomWeapon.type = randomWeaponType
            print("une boite d'arme apparait (type: \(randomWeapon.type) / ", terminator: "")
            
            switch randomWeapon.type {
            case .Damage:
                randomWeapon.damageValue = Int(arc4random_uniform(20)) + 30
                print("dégat: \(randomWeapon.damageValue))")
            case .Healing:
                randomWeapon.healValue = Int(arc4random_uniform(10)) + 20
                print("soin: \(randomWeapon.healValue))")
            }
            
            if selection.weapon.type == randomWeapon.type {
                selection.weapon = randomWeapon
                print("\(selection.name) s'équipe de la nouvelle arme")
            } else {
                print("\(selection.name) ne peux pas s'équiper de cette arme")
            }
        }
    }
    
    // Open the care box and add the life to the character
    private func openCareBox(selection: Character) {
        let careBoxValue = Int(arc4random_uniform(20)) + 10
        
        print("une boite de soin apparait (soin: \(careBoxValue))")
        selection.receveLife(life: careBoxValue)
    }
    
    // Open the armor box and add the armor to the character
    private func openArmorBox(selection: Character) {
        let armorBoxValue = Int(arc4random_uniform(20)) + 10
        
        print("Une boite d'armure apparait (armure: \(armorBoxValue))")
        selection.receveArmor(armor: armorBoxValue)
    }

}
