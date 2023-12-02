//
//  Coordinator.swift
//  PokemonApp
//
//  Created by user245646 on 21/11/23.
//

import Foundation

class Coordinator: ObservableObject {
    private let pokemonRepository : PokemonRepository
    
    init(mock: Bool = false) {
        let networkClient = URLSessionNetworkClient()
        
        //Service
        let pokemonRemoteService: PokemonRemoteService = mock ? MockPokemonRemoteService() : LivePokemonRemoteService(networkClient: networkClient)
        let pokemonLocalService: PokemonLocalService = mock ? MockPokemonLocalService() : UserDefaultsPokemonLocalService()
        //Repository
        self.pokemonRepository = PokemonRepository(remoteService: pokemonRemoteService, localService: pokemonLocalService)
        
    }
    
    //MARK: Pokedex view
    
    func makePokedexView() -> PokedexView {
        return PokedexView(viewModel: makePokedexViewModel())
    }
    
    func makePokedexViewModel() -> PokedexViewModel {
        return PokedexViewModel(pokemonRepository: pokemonRepository)
    }
    
    //MARK: Pokedex view
    func makePokedexDetailView(name: String) -> PokedexDetailView {
        return PokedexDetailView(viewModel: makePokedexDetailViewModel(), name: name)
    }
    
    func makePokedexDetailViewModel() -> PokedexDetailViewModel{
        return PokedexDetailViewModel(pokemonRepository: pokemonRepository)
    }
    
    //MARK: Pokemon game view, funciona igual que la vista de pokedex solo que el pokemon que solicita al repo es random
    func makePokemonGameView() -> PokemonGameView {
        return PokemonGameView(viewModel: makePokedexViewModel())
    }
}
