//
//  ConferenceData.swift
//  ConferenceApp
//
//  Created by 岡野春菜 on 2026/06/06.
//

import SwiftUI
import SwiftData

@Model class ConferenceData {
    init(
        name: String,
        eventDate: Date
    ) {
        self.name = name
        self.eventDate = eventDate
    }

    var name: String
    var eventDate: Date
    @Relationship(inverse: \ConferenceTask.parent)
    var tasks = [ConferenceTask]()
}


