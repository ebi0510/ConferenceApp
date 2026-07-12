//
//  ConferenceApp.swift
//  ConferenceApp
//
//  Created by 岡野春菜 on 2026/06/06.
//

import SwiftUI
import SwiftData

@main
struct ConferenceApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: ConferenceData.self)
    }
}

