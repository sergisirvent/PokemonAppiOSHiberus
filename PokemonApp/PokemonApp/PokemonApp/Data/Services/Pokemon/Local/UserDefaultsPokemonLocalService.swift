//
//  UserDefaultsPokemonLocalService.swift
//  PokemonApp
//
//  Created by user245646 on 21/11/23.
//

import Foundation

struct UserDefaultsPokemonLocalService: PokemonLocalService {

    private let pokemonListKey = "pokemon_name_list"
    private let pokemon = "pokemon_item"
    
    func getPokemonList() async throws -> [PokemonListItem] {
        guard let data = UserDefaults.standard.data(forKey: pokemonListKey) else {
            return []
        }
        
        return try JSONDecoder().decode([PokemonListItem].self, from: data)
    }
    
    func getPokemon(name : String) async throws -> Pokemon{
        guard let data = UserDefaults.standard.data(forKey: pokemon) else {
            return .example
        }
        return try JSONDecoder().decode(Pokemon.self, from: data)
    }
    
    private func savePokemonListName(pokemonList: [PokemonListItem]) async throws {
        let data = try JSONEncoder().encode(pokemonList)
        UserDefaults.standard.set(data, forKey: pokemonListKey)
    }
}
