//
//  ConferenceData.swift
//  ConferenceApp
//
//  Created by 岡野春菜 on 2026/06/06.
//

import SwiftUI

struct ConferenceData: Hashable {
//    なんのデータか見分けがつく名称を使う
    var name: String
    var eventDate: Date
    var cfpStartline: Date?
    var cfpDeadline: Date?
    var sponsorStartline: Date?
    var sponsorDeadline: Date?
    var tasks = [ConferenceTask]()
}


