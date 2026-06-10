//
//  ConferenceView.swift
//  ConferenceApp
//
//  Created by 岡野春菜 on 2026/06/08.
//

import SwiftUI

struct ConferenceView: View {
    @State private var showSheet = false
    var conference: ConferenceData
    
    var body: some View {
        VStack {
            List(conference.tasks, id: \.self) { sampleTask in
                Text(sampleTask.name)
            }
            
            Button {
                showSheet = true
            } label: {
                Text("タスクを追加")
            }
            .sheet(isPresented: $showSheet) {
                SheetView()
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
    @State var taskName = ""
    @State var dueDate = Date()
    
    var body: some View {
        VStack {
            TextField("タスク内容を入力", text: $taskName)
            DatePicker("日時を選択", selection: $dueDate)
        }
        .padding()
    }
}

#Preview {
    ConferenceView(conference: ConferenceData(name: "iOSDC2026", eventDate: Date()))
}
