//
//  AcademateWidget.swift
//  AcademateWidget
//
//  Created by Arin Juan Sari on 17/05/25.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: @preconcurrency TimelineProvider {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([AcademyMateModel.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @MainActor func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), userData: getUserData())
    }
    
    @MainActor func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), userData: getUserData())
        completion(entry)
    }
    
    @MainActor func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [SimpleEntry(date: .now, userData: getUserData())], policy: .after(.now.addingTimeInterval(60*5)))
        completion(timeline)
    }
    
    @MainActor private func getUserData() -> [AcademyMateModel] {
        let descriptor = FetchDescriptor<AcademyMateModel>()
        let userData = try? sharedModelContainer.mainContext.fetch(descriptor)
        
        return userData ?? []
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let userData: [AcademyMateModel]
}

struct AcademateWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    var body: some View {
        VStack(spacing: 0) {
            MediumView(connectionCount: entry.userData.first?.connections.count ?? 0, leaderboardData: getLeaderboardData())
        }
        .containerBackground(for: .widget) {
            Color.clear
        }
    }
    
    func getLeaderboardData() -> LeaderboardModel {
        let userConnect = entry.userData.first?.connections.count ?? 0
        return leaderboardData.first(where: { userConnect >= $0.minConnect && userConnect < $0.maxConnect }) ?? leaderboardData.first!
    }
}

struct MediumView: View {
    var connectionCount: Int
    var leaderboardData: LeaderboardModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(height: .infinity)
            .foregroundColor(leaderboardData.colorButton)
            .overlay(
                ZStack(alignment:.topTrailing) {
                    VStack {
                        HStack(spacing: 0) {
                            VStack(alignment: .leading) {
                                Text("\(connectionCount) Connects")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                
                                Text(leaderboardData.title)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                
                                Text(leaderboardData.personality)
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                    .frame(height: 20)
                                
                                Text(leaderboardData.quotes)
                                    .font(.footnote)
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                            }
                            
                            Spacer()
                            
                            Image(leaderboardData.image)
                        }
                    }
                    .padding(16)
                }
                    .cornerRadius(10)
                    .clipped()
            )
    }
}

struct AcademateWidget: Widget {
    let kind: String = "AcademateWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            AcademateWidgetEntryView(entry: entry)
        }
        .contentMarginsDisabled()
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("Academate Widget")
        .description("Show Your Mate Lists")
    }
}
