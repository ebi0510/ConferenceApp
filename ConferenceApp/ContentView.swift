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
    @Query var sampleContents: [ConferenceData]
    
    var body: some View {
        NavigationStack{
            VStack {
                List(sampleContents, id: \.self) { sampleContent in
                    NavigationLink(destination: ConferenceView(conference: sampleContent)){
                        Text(sampleContent.name)
                        Text(sampleContent.eventDate, style: .date)
                    }
                }
                Button {
                    showSheet = true
                } label: {
                    Text("カンファレンスを追加")
                }
                .sheet(isPresented: $showSheet) {
                    AddConferenceView()
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
    @Environment(\.modelContext) var context
    @State var eventDate = Date()
    @State var conferenceName = ""
    
    var body: some View {
        VStack {
            TextField("カンファレンス名を入力", text: $conferenceName)
            DatePicker("開催日を選択", selection: $eventDate)
            Button {
                context.insert(ConferenceData(name: conferenceName, eventDate: eventDate))
                dismiss()
            } label: {
                Text("カンファレンスを追加")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
