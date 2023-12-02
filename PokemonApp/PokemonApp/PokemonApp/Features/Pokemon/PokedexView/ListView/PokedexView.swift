//
//  PokedexView.swift
//  PokemonApp
//
//  Created by user245646 on 21/11/23.
//

import SwiftUI

struct PokedexView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @StateObject private var viewModel: PokedexViewModel
    
    init(viewModel: PokedexViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            }else{
                 VStack {
                     HStack{
                         Text("Pokedex").font(.title)
                             .fontWeight(.semibold)
                             .foregroundStyle(.white)
                     }
                     
                     List(viewModel.pokemonListItems, id: \.name) {pokemon in
                         NavigationLink {
                             //ir a la vista de detalle
                             coordinator.makePokedexDetailView(name: pokemon.name)
                         } label: {
                             HStack {
                                 AsyncImage(url: pokemon.imageUrl)
                                 Text(pokemon.name.capitalized)
                                     .font(.title2)
                             }
                         }
                     }
                 }.background(.redPokemon)
            }
        }.task {
            await viewModel.getPokemonListItems()
        }.alert("Error", isPresented: Binding.constant(viewModel.error != nil)) {
            Button("OK") {}
            Button("Retry") {
                Task {
                    await viewModel.getPokemonListItems()
                }
            }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "")
        }
    }
}

#Preview {
    let coordinator = Coordinator(mock: false)
    return coordinator.makePokedexView()
        .environmentObject(coordinator)
}
