//
//  PokemonGameView.swift
//  PokemonApp
//
//  Created by user245646 on 21/11/23.
//

import SwiftUI

struct PokemonGameView: View {
    
    @State private var randomPokemon: PokemonListItem = .example
    @State private var textGuess: String = ""
    @State private var textResult: String = ""
    @State private var currentScore: Int = 0
    @State private var hiScore: Int?
    @State private var isCorrect: Bool = false
    private var hiScoreKey: String = "gameHiScore"
    @EnvironmentObject var coordinator: Coordinator
    @StateObject private var viewModel: PokedexViewModel
    
    init(viewModel: PokedexViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        VStack {
            if(viewModel.isLoading){
                ProgressView()
            }else{
                VStack(alignment: .leading) {
                    Text("Game").font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: 40,
                    alignment: .center
                )
                .background(.redPokemon)
                VStack {
                    Text("Score: \(currentScore)")
                        .font(.title2)
                    Text("Best: " + String(hiScore ?? 0))
                        .foregroundStyle(.gray)
                    AsyncImage(url: randomPokemon.imageUrl)
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .border(.redPokemon)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 50, height: 50)))
                    Spacer()
                    if isCorrect {
                        Text(textResult)
                            .font(.title3)
                            .foregroundStyle(.green)
                    }else{
                        Text(textResult)
                            .font(.title3)
                            .foregroundStyle(.red)
                    }
                    
                    Spacer()
                    Text("What is the name of this pokemon?")
                        .font(.headline)
                    TextField("Pokemon name", text: $textGuess)
                        .padding()
                        .frame(width: 300)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        Task {
                            await checkResult()
                        }
                    }) {
                        Text("Submit")
                            .padding()
                            .foregroundColor(.white)
                            .background(.redPokemon)
                            .cornerRadius(10)
                    }.frame(width: 200)
                    Spacer()
                }
                .padding(50)
                .frame(alignment: .center)
                Spacer()
            }
        }.task {
            await loadRandomPokemon()
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
    
    func getHighScore(){
        hiScore = UserDefaults.standard.integer(forKey: hiScoreKey)
    }
    
    func loadRandomPokemon() async {
        
        if viewModel.pokemonListItems.isEmpty {
            await viewModel.getPokemonListItems()
            let randomIndex = Int.random(in: 0..<viewModel.pokemonListItems.count)
            randomPokemon = viewModel.pokemonListItems[randomIndex]
        }else{
            let randomIndex = Int.random(in: 0..<viewModel.pokemonListItems.count)
            randomPokemon = viewModel.pokemonListItems[randomIndex]
        }
        getHighScore()
    }
    
    func checkResult() async {
        let pokemonNameSolution = randomPokemon.name
        if textGuess.uppercased() == randomPokemon.name.uppercased() {
            textResult = "CORRECT"
            currentScore+=1
            isCorrect = true
        }else{
            textResult = "INCORRECT, IT WAS \(pokemonNameSolution.uppercased())"
            isCorrect = false
            
            if currentScore > (hiScore ?? 0) {// check high score
                hiScore = currentScore
                UserDefaults.standard.set(currentScore, forKey: hiScoreKey)
            }
            currentScore = 0
        }
        textGuess = ""
        await loadRandomPokemon()
    }
}

#Preview {
    let coordinator = Coordinator(mock: true)
    return coordinator.makePokemonGameView()
        .environmentObject(coordinator)
}
