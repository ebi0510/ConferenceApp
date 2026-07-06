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
    @Environment(\.modelContext) var context
    
    var body: some View {
        VStack {
            VStack {
                Text("あと\(String(max(0, Calendar.current.dateComponents([.day], from: Date(), to: conference.eventDate).day ?? 0)))日")
                    .font(.title.bold())
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(conference.tasks, id: \.self) { sampleTask in
                            HStack {
                                Button(action: {
                                    sampleTask.isDone.toggle()
                                }) {
                                    if sampleTask.isDone {
                                        Image(systemName: "checkmark.circle.fill").renderingMode(.original)
                                    } else {
                                        Image(systemName: "circle").renderingMode(.original)
                                    }
                                }
                                Text(sampleTask.name)
                                Text(sampleTask.dueDate, style: .date)
                            }
                            .font(.body)
                            .font(.custom("JetBrains Mono", size: 22))
                            .frame(width: 350, height: 70, alignment: .leading)
                            .padding(.horizontal, 40)
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color("CardLayer"))
                            }
                        }
                        .background(Color("Background"))
                    }
                }
            }
            .foregroundStyle(Color("TextPrimary"))
            
            Button {
                showSheet = true
            } label: {
                Text("新しいタスク")
                    .foregroundStyle(Color.black)
            }
            .sheet(isPresented: $showSheet) {
                SheetView(conference: conference)
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color("Accent"))
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding()
        .background(Color("Background"))
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(conference.name)
                    .font(.title.bold())
            }
        }
        .font(.custom("JetBrains Mono", size: 22))
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let item = conference.tasks[index]
                context.delete(item) // 削除を予約
            }
        }
    }
}

struct SheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    @State var taskName = ""
    @State var dueDate = Date()
    @State var type = ""
    @State var deployedAt = Date()
    let conference: ConferenceData
    
    var body: some View {
        VStack {
            TextField("タスク内容を入力", text: $taskName)
            DatePicker("日時を選択", selection: $dueDate, displayedComponents: [.date])
            Button {
                context.insert(ConferenceTask(name: taskName, dueDate: dueDate, type: type, deployedAt: deployedAt, parent: conference))
                dismiss()
            } label: {
                Text("タスクを追加")
            }
        }
        .padding()
    }
}

