//
//  ConferenceData.swift
//  ConferenceApp
//
//  Created by 岡野春菜 on 2026/06/06.
//

import SwiftUI
import SwiftData

@Model class ConferenceData {
    init(name: String, eventDate: Date, cfpDeadline: Date?, sponsorDeadline: Date?) {
        self.name = name
        self.eventDate = eventDate
        self.cfpDeadline = cfpDeadline
        self.sponsorDeadline = sponsorDeadline
    }
//    なんのデータか見分けがつく名称を使う
    var name: String
    var eventDate: Date
    var cfpStartline: Date?
    var cfpDeadline: Date?
    var sponsorStartline: Date?
    var sponsorDeadline: Date?
    @Relationship(inverse: \ConferenceTask.parent)
    var tasks = [ConferenceTask]()
}


