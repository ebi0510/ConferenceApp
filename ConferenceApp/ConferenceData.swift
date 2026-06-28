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
        eventDate: Date,
        sponsorStartline: Date?,
        cfpStartline: Date?,
        cfpDeadline: Date?,
        sponsorDeadline: Date?
    ) {
        self.name = name
        self.eventDate = eventDate
        self.sponsorStartline = sponsorStartline
        self.cfpStartline = cfpStartline
        self.cfpDeadline = cfpDeadline
        self.sponsorDeadline = sponsorDeadline
    }

    var name: String
    var eventDate: Date
    var cfpStartline: Date?
    var cfpDeadline: Date?
    var sponsorStartline: Date?
    var sponsorDeadline: Date?
    @Relationship(inverse: \ConferenceTask.parent)
    var tasks = [ConferenceTask]()
}


