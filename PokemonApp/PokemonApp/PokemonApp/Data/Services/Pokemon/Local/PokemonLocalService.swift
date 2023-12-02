//
//  PokemonLocalService.swift
//  PokemonApp
//
//  Created by user245646 on 21/11/23.
//

import Foundation

protocol PokemonLocalService {
    func getPokemonList() async throws -> [PokemonListItem]
    func getPokemon(name: String) async throws -> Pokemon
}
