//
//  Pokemon.swift
//  PokemonApp
//
//  Created by user245646 on 21/11/23.
//

import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let order: Int
    let weight: Int
    let height: Int
    let types: [TypeElement]
    let abilities: [Ability]
    var imageUrl: URL {
        let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
        
        if let url {
            return url
        }else{
            return URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Pok%C3%A9_Ball_icon.svg/2052px-Pok%C3%A9_Ball_icon.svg.png")!//pongo una exclamacion ya que al ser una url statica, estoy seguro de que existe
        }
    }
    
    static var example: Pokemon {
        return Pokemon(id: 1, name: "Bulbasaur", order: 1, weight: 100, height: 100,types: [],abilities: [])
    }
    
    struct Ability: Codable {
        let ability: Species
        let isHidden: Bool
        let slot: Int

        enum CodingKeys: String, CodingKey {
            case ability
            case isHidden = "is_hidden"
            case slot
        }
    }
    struct Species: Codable {
        let name: String
        let url: String
    }
    
    // MARK: - TypeElement
    struct TypeElement: Codable {
        let slot: Int
        let type: Species
    }
}



