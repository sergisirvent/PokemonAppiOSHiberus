//
//  ListItemPokemon.swift
//  PokemonApp
//
//  Created by user245646 on 21/11/23.
//

import Foundation

struct PokemonListItem: Codable {
    let name: String
    let url: String
    var id: Int? {
            return Int(url.split(separator: "/").last?.description ?? "0")//separamos el numero de la id de la url
    }
        
    var imageUrl: URL {
        let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id ?? 0).png")
        
        if let url {
            return url
        }else{
            return URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Pok%C3%A9_Ball_icon.svg/2052px-Pok%C3%A9_Ball_icon.svg.png")!//pongo una exclamacion ya que al ser una url statica, estoy seguro de que existe
        }
    }
    
    init(name: String, url: String, id: Int, imageUrl: URL) {
        self.name = name
        self.url = url
    }
    
    
    
    static var example: PokemonListItem {
        return PokemonListItem(name: "Ditto", url: "", id: 1, imageUrl: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/.png")!)
    }
}
