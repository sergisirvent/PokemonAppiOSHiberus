//
//  LivePokemonRemoteService.swift
//  PokemonApp
//
//  Created by user245646 on 21/11/23.
//

import Foundation

struct LivePokemonRemoteService: PokemonRemoteService {
    
    
    
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getPokemonList() async throws -> [PokemonListItem] {
        let response: APIResponse<PokemonListItem> = try await networkClient.getCall(url: NetworkConstants.pokemonUrl, queryParams: nil)
        
        return response.results
    }
    
    func getPokemon(name: String) async throws -> Pokemon {
        let response: Pokemon = try await networkClient.getCall(url: NetworkConstants.pokemonUrl+"/\(name)", queryParams: nil)
        return response
    }
    
    
    
}
