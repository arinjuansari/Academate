//
//  SplashViewModel.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 12/05/25.
//
import Foundation
import SwiftData

@Observable
final class SplashViewModel {
    var modelContext: ModelContext
    var userData: [AcademyMateModel] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadUserData()
    }
    
    func loadUserData() {
        do {
            let descriptor = FetchDescriptor<AcademyMateModel>()
            userData = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed")
        }
    }
    
    var isShowLogo: Bool = false
    
    func showLogo() {
        isShowLogo = true
    }
}
