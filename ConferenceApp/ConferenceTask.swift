//
//  ConferenceTask.swift
//  ConferenceApp
//
//  Created by 岡野春菜 on 2026/06/06.
//

import SwiftUI
import SwiftData

@Model class ConferenceTask {
    init(
        name: String,
        dueDate: Date,
        type: String,
        deployedAt: Date?,
        parent: ConferenceData?
    ) {
        self.name = name
        self.type = type
        self.dueDate = dueDate
        self.deployedAt = deployedAt
        self.isDone = false
        self.parent = parent
    }
    
    var name: String
    var type: String
    var dueDate: Date
    var deployedAt: Date?
    var isDone: Bool
    var parent: ConferenceData?
}
