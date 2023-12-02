//
//  ContentView.swift
//  StarWars
//
//  Created by user245646 on 15/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        
         
         TabView {
             Group {
                 coordinator.makePokedexView()
                     .tabItem {
                         Label("Pokedex", systemImage: "filemenu.and.selection")
                     }
                 coordinator.makePokemonGameView()//cambiar
                     .tabItem {
                         Label("Game", systemImage: "gamecontroller")
                     }
             }.toolbarBackground(.redPokemon, for: .tabBar)
                 .toolbarBackground(.visible, for: .tabBar)
                 .toolbarColorScheme(.dark, for: .tabBar)
             
                 
         }
         
         
        
    }
}

#Preview {
    let coordinator = Coordinator(mock: true)
    return ContentView()
        .environmentObject(coordinator)
}
