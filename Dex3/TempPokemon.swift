//
//  TempPokemon.swift
//  Dex3
//
//  Created by Ruben Movsisyan on 3/30/24.
//

import Foundation

struct TempPokemon: Decodable {
    var id: Int
    var name: String
    var types: [String]
    var hp = 0
    var attack = 0
    var defense = 0
    var specialAttack = 0
    var specialDefense = 0
    var speed = 0
    var sprites: URL
    var shiny: URL
    
    enum PokemonKeys: String, CodingKey {
        case id
        case name
        case types
        case stats
        case sprites
        
        enum TypeDictKeys: String, CodingKey {
            case type
            
            enum TypeKeys: String, CodingKey {
                case name
            }
        }
        
        enum StatDictKeys: String, CodingKey {
            case value = "base_stat"
            case stat
            
            enum StatKeys: String, CodingKey {
                case name
            }
        }
        
        enum SpriteKeys: String, CodingKey {
            case sprite = "front_default"
            case shiny = "front_shiny"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        
        var decodedTypes: [String] = []
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        
        while !typesContainer.isAtEnd {
            let typesDictContainer = try typesContainer.nestedContainer(keyedBy: PokemonKeys.TypeDictKeys.self)
            let typeContainer = try typesDictContainer.nestedContainer(keyedBy: PokemonKeys.TypeDictKeys.TypeKeys.self, forKey: .type)
            
            let type = try typeContainer.decode(String.self, forKey: .name)
            decodedTypes.append(type)
        }
        
        self.types = decodedTypes
        
        var statsContainer = try container.nestedUnkeyedContainer(forKey: .stats)
        
        while !statsContainer.isAtEnd {
            let statsDictContainer = try statsContainer.nestedContainer(keyedBy: PokemonKeys.StatDictKeys.self)
            let statContainer = try statsDictContainer.nestedContainer(keyedBy: PokemonKeys.StatDictKeys.StatKeys.self, forKey: .stat)
            
            switch try statContainer.decode(String.self, forKey: .name) {
            case "hp":
                self.hp = try statsDictContainer.decode(Int.self, forKey: .value)
            case "attack":
                self.attack = try statsDictContainer.decode(Int.self, forKey: .value)
            case "defense":
                self.defense = try statsDictContainer.decode(Int.self, forKey: .value)
            case "special-attack":
                self.specialAttack = try statsDictContainer.decode(Int.self, forKey: .value)
            case "special-defense":
                self.specialDefense = try statsDictContainer.decode(Int.self, forKey: .value)
            case "speed":
                self.speed = try statsDictContainer.decode(Int.self, forKey: .value)
            default:
                print("")
            }
        }
    
        let spriteContainer = try container.nestedContainer(keyedBy: PokemonKeys.SpriteKeys.self, forKey: .sprites)
        
        self.sprites = try spriteContainer.decode(URL.self, forKey: .sprite)
        self.shiny = try spriteContainer.decode(URL.self, forKey: .shiny)
    }
}
