//
//  PokemonAppApp.swift
//  PokemonApp
//
//  Created by user245646 on 14/11/23.
//

import SwiftUI

@main
struct PokemonAppApp: App {
    
    let coordinator = Coordinator()
    
    var body: some Scene {
        WindowGroup {
            /*
             ContentView()
                 .environmentObject(coordinator)
             */
            SplashScreenView()
                .environmentObject(coordinator)
            
        }
    }
}
