//
//  PokemonRepository.swift
//  PokemonApp
//
//  Created by user245646 on 21/11/23.
//

import Foundation

struct PokemonRepository {
    let remoteService: PokemonRemoteService
    let localService: PokemonLocalService
    
    init(remoteService: PokemonRemoteService, localService: PokemonLocalService) {
        self.remoteService = remoteService
        self.localService = localService
    }
    
    func getPokemonList() async throws -> [PokemonListItem] {
        return try await remoteService.getPokemonList()
    }
    
    
     
     func getPokemon(name: String) async throws -> Pokemon {
         return try await remoteService.getPokemon(name: name)
     }
     
     

}
