//
//  LaunchView.swift
//  ConferenceApp
//
//  Created by 岡野春菜 on 2026/07/10.
//

import SwiftUI

struct LaunchView: View {
    @State var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                VStack(alignment: .center) {
                    Circle()
                        .fill(Color("Accent"))
                        .frame(width: 15)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color("TextSecondary"))
                        .frame(width: 6, height: 50)
                    
                    Text("TechPR Flow")
                        .font(.custom("JetBrains Mono", size: 22))
                        .foregroundStyle(.white)
                }
            }
            .transition(.opacity)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeInOut(duration: 0.5)){
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchView()
}
