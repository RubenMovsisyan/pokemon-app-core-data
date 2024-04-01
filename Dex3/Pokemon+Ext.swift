//
//  Pokemon+Ext.swift
//  Dex3
//
//  Created by Ruben Movsisyan on 3/31/24.
//

import Foundation

extension Pokemon {
    var background: String {
        switch self.types![0] {
        case "normal", "grass", "electric", "poison", "fairy":
            "normalgrasselectricpoisonfairy"
        case "rock", "ground", "steel", "fighting", "ghost", "dark", "psychic":
            "rockgroundsteelfightingghostdarkpsychic"
        case "fire", "dragon":
            "firedragon"
        case "flying", "bug":
            "flyingbug"
        case "ice":
            "ice"
        case "water":
            "water"
        default:
            ""
        }
    }
    
    var stats: [Stat] {
        [
            Stat(id: 1, label: "HP", value: self.hp),
            Stat(id: 2, label: "Attack", value: self.attack),
            Stat(id: 3, label: "Defense", value: self.defense),
            Stat(id: 4, label: "Special Attack", value: self.specialAttack),
            Stat(id: 5, label: "Special Defense", value: self.specialDefense),
            Stat(id: 6, label: "Speed", value: self.speed)
        ]
    }
    
    var highestStat: Stat {
        stats.max { $0.value < $1.value }!
    }
    
    func organizeTypes() {
        if self.types!.count == 2, self.types![0] == "normal" {
            self.types!.swapAt(0, 1)
        }
    }
}

struct Stat: Identifiable {
    let id: Int
    let label: String
    let value: Int16
}
