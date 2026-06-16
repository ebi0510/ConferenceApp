//
//  Task.swift
//  ConferenceApp
//
//  Created by 岡野春菜 on 2026/06/06.
//

import SwiftUI
import SwiftData

@Model class ConferenceTask {
    init(name: String, dueDate: Date) {
        self.name = name
        self.dueDate = dueDate
    }
    
    var name : String
    var dueDate : Date
    var parent : ConferenceData?
}
