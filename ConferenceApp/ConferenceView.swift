//
//  ConferenceView.swift
//  ConferenceApp
//
//  Created by 岡野春菜 on 2026/06/08.
//

import SwiftUI

struct ConferenceView: View {
    let conference: ConferenceData
    
    var body: some View {
        VStack {
            List(conference.tasks, id: \.self) { sampleTask in
                Text(sampleTask.name)
            }
        }
        .padding()
    }
}

#Preview {
    ConferenceView(conference: ConferenceData(name: "iOSDC2026", eventDate: Date()))
}
