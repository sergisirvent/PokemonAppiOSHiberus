//
//  PokedexDetailView.swift
//  PokemonApp
//
//  Created by user245646 on 30/11/23.
//

import SwiftUI

struct PokedexDetailView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    @StateObject private var viewModel: PokedexDetailViewModel
    
    let name: String
    
    init(viewModel: PokedexDetailViewModel, name: String) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.name = name
    }
    
    var body: some View {
        
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
            }else if let pokemon = viewModel.pokemon {
                VStack(alignment: .center, spacing: 8) {
                    AsyncImage(url: pokemon.imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                    } placeholder: {
                        ProgressView()
                    }
                    .cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Name:")
                            .font(.headline)
                            .foregroundColor(.redPokemon)
                        Text(pokemon.name.capitalized)
                            .font(.title)
                        
                        Text("Number in Pokédex:")
                            .font(.headline)
                            .foregroundColor(.redPokemon)
                        Text("\(pokemon.order)")
                            .font(.title2)
                        
                        Text("Weight:")
                            .font(.headline)
                            .foregroundColor(.redPokemon)
                        Text("\(pokemon.weight) kg")
                            .font(.title2)
                        
                        Text("Height:")
                            .font(.headline)
                            .foregroundColor(.redPokemon)
                        Text("\(pokemon.height) m")
                            .font(.title2)
                        
                        Text("Types:")
                            .font(.headline)
                            .foregroundColor(.redPokemon)
                        Text(pokemon.types.map { $0.type.name }.joined(separator: ", "))
                            .font(.title2)
                        
                        Text("Abilities:")
                            .font(.headline)
                            .foregroundColor(.redPokemon)
                        Text(pokemon.abilities.map { $0.ability.name }.joined(separator: ", "))
                            .font(.title2)
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
                }.padding(16)
                    .navigationBarTitle(Text("\(pokemon.name.capitalized) details"), displayMode: .inline)
                
            }
        }.task {
            await viewModel.getPokemon(name: name)
        }.alert("Error",isPresented: Binding.constant(viewModel.error != nil)) {
            Button("OK"){}
            Button("Retry") {
                Task {
                    await viewModel.getPokemon(name:name)
                }
            }
            
        }message: {
            Text(viewModel.error?.localizedDescription ?? "")
        }
        
    }
    
}

#Preview {
    let coordinator = Coordinator(mock: true)
    return coordinator.makePokedexDetailView(name: "")
        .environmentObject(coordinator)
}
