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
                Text("あと\n\(String(max(0, Calendar.current.dateComponents([.day], from: Date(), to: conference.eventDate).day ?? 0)))日")
                    .font(.title.bold())
                    .padding(.bottom, 30)
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(conference.tasks.sorted { $0.dueDate < $1.dueDate }, id: \.self) { sampleTask in
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
                                Text(sampleTask.isDone ? "● deployed:" : "\(sampleTask.type.emoji) \(sampleTask.type.rawValue):")
                                    .foregroundColor(sampleTask.isDone ? Color("Accent") : .secondary)
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
                            .contextMenu {
                                Button(role: .destructive) {
                                    context.delete(sampleTask)
                                } label: {
                                    Label("削除", systemImage: "trash")
                                }
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
                Text("Add Task")
                    .foregroundStyle(Color.black).bold()
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
        .navigationBarTitleDisplayMode(.inline)
        .font(.custom("JetBrains Mono", size: 22))
    }
}

struct SheetView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    @State var taskName = ""
    @State var dueDate = Date()
    @State private var selectedType: TaskType = .docs
    @State var deployedAt: Date? = nil
    let conference: ConferenceData
    
    var body: some View {
        VStack(spacing: 20) {
            Picker("タイプ", selection: $selectedType) {
                ForEach(TaskType.allCases) { type in
                    Text("\(type.emoji) \(type.rawValue)")
                }
            }
            .pickerStyle(.segmented)
            TextField("タスク内容を入力", text: $taskName)
            DatePicker("日時を選択", selection: $dueDate, displayedComponents: [.date])
            Button {
                context.insert(ConferenceTask(name: taskName, dueDate: dueDate, type: selectedType, deployedAt: deployedAt, parent: conference))
                dismiss()
            } label: {
                Text("Add")
                    .foregroundStyle(Color.black).bold()
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color("Accent"))
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding(30)
        .font(.custom("JetBrains Mono", size: 22))
    }
}

