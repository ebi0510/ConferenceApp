//
//  ContentView.swift
//  ConferenceApp
//
//  Created by 岡野春菜 on 2026/06/06.
//

import SwiftUI

struct ContentView: View {
    @State private var showSheet = false
    @State var sampleContents = [
        ConferenceData(
            name: "iOSDC2026",
            eventDate: Date()
        ),
        ConferenceData(
            name: "DroidKaigi2026",
            eventDate: Date()
        )]
    
    var body: some View {
        NavigationStack{
            VStack {
                List(sampleContents, id: \.self) { sampleContent in
                    NavigationLink(destination: ConferenceView(conference: sampleContent)){
                        Text(sampleContent.name)
                    }
                }
                Button {
                    showSheet = true
                } label: {
                    Text("カンファレンスを追加")
                }
                .sheet(isPresented: $showSheet) {
//                    AddConferenceView(sampleContents: $sampleContents)
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
}

struct AddConferenceView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var conference: ConferenceData
    @State var taskName = ""
    @State var dueDate = Date()
    
    var body: some View {
        VStack {
            TextField("タスク内容を入力", text: $taskName)
            DatePicker("日時を選択", selection: $dueDate)
            Button {
                conference.tasks.append(ConferenceTask(name: taskName, dueDate: dueDate))
                dismiss()
            } label: {
                Text("タスクを追加")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
