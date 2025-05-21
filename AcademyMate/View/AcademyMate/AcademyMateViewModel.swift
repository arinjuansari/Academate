//
//  AcademyMateViewModel.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 13/05/25.
//
import Foundation
import SwiftData

@Observable
final class AcademyMateViewModel {
    var modelContext: ModelContext
    var navigation: Navigation
    
    var data: AcademyMateModel?
    var searchText: String = ""
    
    var userConnection: [String] {
        data?.connections ?? []
    }
    
    var users: [AcademyMateModel] {
        let allUsers = academyMateData.filter { data?.name != $0.name }
        let connectedUsers = allUsers.filter { userConnection.contains($0.name) }
        let unconnectedUsers = allUsers.filter { !(userConnection.contains($0.name)) }
        let users = if (connectedUsers.isEmpty) { allUsers } else { connectedUsers + unconnectedUsers }
        
        return users
    }
    
    var filteredData: [AcademyMateModel] {
        users.filter { searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    var notFound: Bool {
        !searchText.isEmpty && users.filter { $0.name.lowercased().contains(searchText.lowercased()) }.isEmpty
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
