//
//  PokedexDetailViewModel.swift
//  PokemonApp
//
//  Created by user245646 on 30/11/23.
//

import Foundation

class PokedexDetailViewModel: ObservableObject {
    private let pokemonRepository: PokemonRepository
        
        @Published var isLoading = false
        @Published var pokemon: Pokemon?
        @Published var error: Error?
        
    init(pokemonRepository: PokemonRepository) {
            self.pokemonRepository = pokemonRepository
        }
        
        @MainActor
    func getPokemon(name: String) async {
            error = nil
            isLoading = true
            
            do {
                pokemon = try await pokemonRepository.getPokemon(name: name)
            } catch(let error) {
                self.error = error
            }
            
            isLoading = false
    }
}
