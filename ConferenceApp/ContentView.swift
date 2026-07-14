//
//  ContentView.swift
//  ConferenceApp
//
//  Created by 岡野春菜 on 2026/06/06.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showSheet = false
    @Environment(\.modelContext) var context
    @Query(sort: \ConferenceData.eventDate, order: .forward) var sampleContents: [ConferenceData]
    
    var body: some View {
        NavigationStack{
            VStack {
                ScrollView {
                    VStack (spacing: 12){
                        ForEach(sampleContents, id: \.self) { sampleContent in
                            NavigationLink (destination: ConferenceView(conference: sampleContent)){
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(sampleContent.name).lineLimit(1)
                                        .font(.title.bold())
                                        .foregroundStyle(Color("TextPrimary"))
                                    Text("あと\(String(max(0, Calendar.current.dateComponents([.day], from: Date(), to: sampleContent.eventDate).day ?? 0)))日")
                                        .font(.title2)
                                        .foregroundStyle(Color("TextSecondary"))
                                }
                                .frame(width: 350, height: 120, alignment: .leading)
                                .padding(.horizontal, 40)
                                .background {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color("CardLayer"))
                                }
                                .font(.custom("JetBrains Mono", size: 22))
                            }
                            .contextMenu {
                                Button(role: .destructive) {
                                    context.delete(sampleContent)
                                } label: {
                                    Label("削除", systemImage: "trash")
                                }
                            }
                            .toolbar {
                                ToolbarItem(placement: .principal) {
                                    Text("協賛一覧")
                                        .font(.title.bold())
                                }
                            }
                            .navigationBarTitleDisplayMode(.inline)
                        }
                    }
                }
                .background(Color("Background"))
                
                Button {
                    showSheet = true
                } label: {
                    Text("Add Conference")
                        .foregroundStyle(Color.black).bold()
                }
                .sheet(isPresented: $showSheet) {
                    AddConferenceView()
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color("Accent"))
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding()
        }
        
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let item = sampleContents[index]
                context.delete(item) // 削除を予約
            }
        }
    }
}

struct AddConferenceView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var context
    @State var eventDate = Date()
    @State var conferenceName = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("カンファレンス名を入力", text: $conferenceName)
            DatePicker("開催日を入力", selection: $eventDate, displayedComponents: [.date])
        }
        .padding(30)
        
        Button {
            context.insert(ConferenceData(
                name: conferenceName,
                eventDate: eventDate
            ))
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
        .disabled(conferenceName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
}


#Preview {
    ContentView()
}
