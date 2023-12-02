//
//  SplashScreenView.swift
//  PokemonApp
//
//  Created by user245646 on 1/12/23.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        
        if isActive {
            ContentView()
                .environmentObject(coordinator)
        }else{
            VStack{
                LottieView(filename: "lottie_animation_splasg", loopMode: .loop)
                    .frame(width: 300, height: 300)
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                    withAnimation{
                        self.isActive = true
                    }
                    
                }
            }
        }
        
        
    }
}

#Preview {
    let coordinator = Coordinator(mock: false)
    return SplashScreenView()
        .environmentObject(coordinator)
}
