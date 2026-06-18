//
//  ConferenceView.swift
//  ConferenceApp
//
//  Created by 岡野春菜 on 2026/06/08.
//

import SwiftUI
import SwiftData

struct ConferenceView: View {
    @State private var showSheet = false
    @State var conference: ConferenceData
    
    var body: some View {
        VStack {
            List(conference.tasks, id: \.self) { sampleTask in
                HStack {
                    Text(sampleTask.name)
                    Text(sampleTask.dueDate, style: .date)
                }
            }
            
            Button {
                showSheet = true
            } label: {
                Text("タスクを追加")
            }
            .sheet(isPresented: $showSheet) {
                SheetView(conference: conference)
            }
            .padding(15)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2) // 枠線の色と太さ
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding()
    }
}

struct SheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    @State var taskName = ""
    @State var dueDate = Date()
    let conference: ConferenceData
    
    var body: some View {
        VStack {
            TextField("タスク内容を入力", text: $taskName)
            DatePicker("日時を選択", selection: $dueDate)
            Button {
                context.insert(ConferenceTask(name: taskName, dueDate: dueDate, parent: conference))
                dismiss()
            } label: {
                Text("タスクを追加")
            }
        }
        .padding()
    }
}

#Preview {
    ConferenceView(conference: ConferenceData(name: "iOSDC2026", eventDate: Date()))
}
