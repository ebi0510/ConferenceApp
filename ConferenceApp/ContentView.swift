//
//  ContentView.swift
//  ConferenceApp
//
//  Created by 岡野春菜 on 2026/06/06.
//

import SwiftUI

struct ContentView: View {
    let sampleContents = [
        ConferenceData(
            name: "iOSDC2026",
            eventDate: Date()
        ),
        ConferenceData(
            name: "DroidKaigi2026",
            eventDate: Date()
        )]
    
    var body: some View {
        NavigationStack{
            VStack {
                List(sampleContents, id: \.self) { sampleContent in
                    NavigationLink(destination: ConferenceView(conference: sampleContent)){
                        Text(sampleContent.name)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
