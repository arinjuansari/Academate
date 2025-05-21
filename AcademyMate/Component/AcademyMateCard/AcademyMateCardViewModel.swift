//
//  AcademyMateCardViewModel.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 13/05/25.
//

import Foundation
import SwiftData

@Observable
final class AcademyMateCardViewModel {
    var modelContext: ModelContext
    var navigation: Navigation
    
    var data: AcademyMateModel?
    var userConnection: [String] {
        data?.connections ?? []
    }
    
    func filterUsers() -> [AcademyMateModel] {
        let allUsers = academyMateData.filter { data?.name != $0.name }
        let connectedUsers = allUsers.filter { userConnection.contains($0.name) }
        let unconnectedUsers = allUsers.filter { !(userConnection.contains($0.name)) }
        let users = connectedUsers.isEmpty ? allUsers : connectedUsers + unconnectedUsers
        
        return users
    }
    
    func lockedProfile(data: AcademyMateModel) {
        navigation.path.append(NavigationModel(destination: "Profile", data: data))
    }
    
    init(modelContext: ModelContext, navigation: Navigation, data: AcademyMateModel? = nil) {
        self.modelContext = modelContext
        self.navigation = navigation
        self.data = data
    }
}
