//
//  ConferenceTask.swift
//  ConferenceApp
//
//  Created by 岡野春菜 on 2026/06/06.
//

import SwiftUI
import SwiftData

enum TaskType: String, CaseIterable, Identifiable, Codable {
    case docs = "docs"
    case design = "design"
    case chore = "chore"
    
    // Identifiableに適合させるため（Pickerなどでループ回す時に便利）
    var id: Self { self }
    
    // UIで表示するための絵文字
    var emoji: String {
        switch self {
        case .docs: return "📝"
        case .design: return "🎨"
        case .chore: return "📦"
        }
    }
}

@Model class ConferenceTask {
    init(
        name: String,
        dueDate: Date,
        type: TaskType,
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
    var type: TaskType
    var dueDate: Date
    var deployedAt: Date?
    var isDone: Bool
    var parent: ConferenceData?
}
