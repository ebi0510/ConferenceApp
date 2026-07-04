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
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            Text("協賛一覧")
                                .font(.title.bold())
                        }
                    }
                }
                }
                }
                .background(Color("Background"))
                
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
    @State var sponsorStartline = Date()
    @State var cfpStartline = Date()
    @State var cfpDeadline = Date()
    @State var sponsorDeadline = Date()
    @State var hasSponsorStartline = false
    @State var hasCfpStartline = false
    @State var hasCfpDeadline = false
    @State var hasSponsorDeadline = false
    
    var body: some View {
        VStack {
            TextField("カンファレンス名を入力", text: $conferenceName)
            
            DatePicker("開催日を入力", selection: $eventDate, displayedComponents: [.date])
            
            Toggle("CfP募集開始", isOn: $hasCfpStartline)
            if hasCfpStartline {
                DatePicker(
                    "CfP募集開始日を入力",
                    selection: $cfpStartline,
                    displayedComponents: [.date]
                )
            }
            
            Toggle("CfP締切", isOn: $hasCfpDeadline)
            if hasCfpDeadline {
                DatePicker(
                    "CfP締切を入力",
                    selection: $cfpDeadline,
                    displayedComponents: [.date]
                )
            }
            
            Toggle("協賛申込開始", isOn: $hasSponsorStartline)
            if hasSponsorStartline {
                DatePicker(
                    "協賛申込開始日を入力",
                    selection: $sponsorStartline,
                    displayedComponents: [.date]
                )
            }
            
            Toggle("協賛申込締切", isOn: $hasSponsorDeadline)
            if hasSponsorDeadline {
                DatePicker(
                    "協賛申込締切を入力",
                    selection: $sponsorDeadline,
                    displayedComponents: [.date]
                )
            }
            
            Button {
                context.insert(ConferenceData(
                    name: conferenceName,
                    eventDate: eventDate,
                    sponsorStartline: hasSponsorStartline ? sponsorStartline : nil,
                    cfpStartline: hasCfpStartline ? cfpStartline : nil,
                    cfpDeadline: hasCfpDeadline ? cfpDeadline : nil,
                    sponsorDeadline: hasSponsorDeadline ? sponsorDeadline : nil
                ))
                dismiss()
            } label: {
                Text("カンファレンスを追加")
            }
            .disabled(conferenceName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
