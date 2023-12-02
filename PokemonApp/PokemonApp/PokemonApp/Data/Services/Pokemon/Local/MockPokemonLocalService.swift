//
//  MockPokemonLocalService.swift
//  PokemonApp
//
//  Created by user245646 on 21/11/23.
//

import Foundation

struct MockPokemonLocalService: PokemonLocalService {
    func getPokemon(name: String) async throws -> Pokemon {
        return .example
    }
    
    
    func getPokemonList() async throws -> [PokemonListItem] {
        return [.example,.example]
    }
    
    
    
}
