//
//  PokedexViewModel.swift
//  PokemonApp
//
//  Created by user245646 on 21/11/23.
//

import Foundation

class PokedexViewModel: ObservableObject {
    private let pokemonRepository: PokemonRepository
        
        @Published var isLoading = false
        @Published var pokemonListItems: [PokemonListItem] = []
        @Published var error: Error?
        
        init(pokemonRepository: PokemonRepository) {
            self.pokemonRepository = pokemonRepository
        }
        
        @MainActor
        func getPokemonListItems() async {
            error = nil
            isLoading = true
            
            do {
                pokemonListItems = try await pokemonRepository.getPokemonList()
            } catch(let error) {
                self.error = error
            }
            
            isLoading = false
    }
}

