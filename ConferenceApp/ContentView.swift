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
                List{ ForEach(sampleContents, id: \.self) { sampleContent in
                    NavigationLink(destination: ConferenceView(conference: sampleContent)){
                        Text(sampleContent.name)
                        Text(sampleContent.eventDate, style: .date)
                    }
                }
                .onDelete(perform: deleteItems)
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
    @State var cfpDeadline = Date()
    @State var sponsorDeadline = Date()
    @State var hasCfpDeadline = false
    @State var hasSponsorDeadline = false
    
    var body: some View {
        VStack {
            TextField("カンファレンス名を入力", text: $conferenceName)
            
            DatePicker("開催日を入力", selection: $eventDate, displayedComponents: [.date])
            Toggle("CfP締切", isOn: $hasCfpDeadline)
            if hasCfpDeadline {
                DatePicker("CfP締切を入力", selection: $cfpDeadline, displayedComponents: [.date])
            }
            Toggle("協賛申し込み締切", isOn: $hasSponsorDeadline)
            if hasSponsorDeadline {
                DatePicker("協賛申し込み締切を入力", selection: $sponsorDeadline, displayedComponents: [.date])
            }
            
            
            Button {
                context.insert(ConferenceData(
                    name: conferenceName,
                    eventDate: eventDate,
                    cfpDeadline: hasCfpDeadline ? cfpDeadline : nil,
                    sponsorDeadline: hasSponsorDeadline ? sponsorDeadline : nil
                ))
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
