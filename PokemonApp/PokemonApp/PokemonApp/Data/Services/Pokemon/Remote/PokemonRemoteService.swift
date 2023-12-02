//
//  PokemonRemoteService.swift
//  PokemonApp
//
//  Created by user245646 on 21/11/23.
//

import Foundation

protocol PokemonRemoteService {
    func getPokemonList() async throws -> [PokemonListItem]
    func getPokemon(name: String) async throws -> Pokemon
    //func getPokemon(url: String) async throws -> Pokemon
}
