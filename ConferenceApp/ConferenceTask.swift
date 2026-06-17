//
//  Task.swift
//  ConferenceApp
//
//  Created by 岡野春菜 on 2026/06/06.
//

import SwiftUI
import SwiftData

@Model class ConferenceTask {
    init(name: String, dueDate: Date, parent: ConferenceData?) {
        self.name = name
        self.dueDate = dueDate
        self.parent = parent
    }
    
    var name : String
    var dueDate : Date
    var parent : ConferenceData?
}
