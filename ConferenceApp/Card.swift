//
//  Card.swift
//  ConferenceApp
//
//  Created by 岡野春菜 on 2026/07/02.
//

import SwiftUI
import SwiftData

struct CardView: View {
    @Environment(\.modelContext) var context
    @Query var sampleContents: [ConferenceData]
    
    var body: some View {
        VStack {
            ForEach(sampleContents, id: \.self) { sampleContent in
                NavigationLink(destination: ConferenceView(conference: sampleContent)){
                    VStack(alignment: .leading, spacing: 10) {
                        Text(sampleContent.name).lineLimit(1)
                            .font(.title.bold())
                            .foregroundStyle(.white)
                        Text("開催まであと\(String(max(0, Calendar.current.dateComponents([.day], from: Date(), to: sampleContent.eventDate).day ?? 0)))日")
                            .font(.title2)
                            .foregroundStyle(Color("TextSecondary"))
                    }
                }
            }
        }
        .font(.custom("JetBrains Mono", size: 22))
        .frame(width: 350, height: 120, alignment: .leading)
        .padding(.leading, 30)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("CardLayer"))
        }
    }
}

#Preview {
    CardView()
    // 💡 プレビュー専用のコンテナを作り、その場で固定データを投入する
        .modelContainer(PreviewContainer.makeSampleContainer())
}

// プレビュー用のデータ作成用構造体
private struct PreviewContainer {
    @MainActor
    static func makeSampleContainer() -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: ConferenceData.self, configurations: config)
        
        // 表示したい固定データ
        let sample1 = ConferenceData(
            name: "カンファレンスA",
            eventDate: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
            sponsorStartline: nil, cfpStartline: nil, cfpDeadline: nil, sponsorDeadline: nil
        )
        
        container.mainContext.insert(sample1)
        
        return container
    }
}
