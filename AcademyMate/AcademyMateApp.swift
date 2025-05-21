//
//  AcademyMateApp.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 09/05/25.
//

import SwiftUI
import SwiftData

@main
struct AcademyMateApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: AcademyMateModel.self)
        } catch {
            fatalError("Failed to create ModelContainer for Movie.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView(modelContext: container.mainContext)
                .modelContainer(container)
        }
    }
}
