//
//  HomeViewModel.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 12/05/25.
//

import Foundation
import SwiftData

@Observable
final class HomeViewModel {
    var modelContext: ModelContext
    var navigation: Navigation
    
    var userData: [AcademyMateModel] = []
    var selectedUserData: AcademyMateModel? {
        userData.first
    }
    var userPhoto: String {
        selectedUserData?.name ?? ""
    }
    var userName: String {
        selectedUserData?.name ?? ""
    }
    var userEmail: String {
        selectedUserData?.email ?? ""
    }
    var userConnectionCount: Int {
        selectedUserData?.connections.count ?? 0
    }
    var userLeaderboardData: LeaderboardModel {
        getLeaderboardData(userData: selectedUserData)
    }
    
    init(modelContext: ModelContext, navigation: Navigation) {
        self.modelContext = modelContext
        self.navigation = navigation
        
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
    
    func getLeaderboardData(userData: AcademyMateModel?) -> LeaderboardModel {
        let userConnect = userData?.connections.count ?? 0
        return leaderboardData.first(where: { userConnect >= $0.minConnect && userConnect < $0.maxConnect }) ?? leaderboardData.first!
    }
    
}
