//
//  SuccessViewModel.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 13/05/25.
//

import Foundation
import SwiftData
import WidgetKit

@Observable
final class SuccessViewModel {
    var modelContext: ModelContext
    var navigation: Navigation
    var data: AcademyMateModel
    var isError: Bool = false
    var errorMessage: String = ""
    
    var userData: [AcademyMateModel] = []
    var selectedUserData: AcademyMateModel? {
        userData.first
    }
    
    init(modelContext: ModelContext, navigation: Navigation, data: AcademyMateModel) {
        self.modelContext = modelContext
        self.navigation = navigation
        self.data = data
        
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
    
    func handleError() {
        if userData.first?.name != data.name {
            var currenctConnection = userData.first?.connections
            if !(currenctConnection?.contains(data.name) ?? false) {
                currenctConnection?.append(data.name)
                
                userData.first?.connections = currenctConnection ?? []
                try? modelContext.save()
                WidgetCenter.shared.reloadAllTimelines()
            } else {
                isError = true
                errorMessage = "\(data.name) is already in your connection list!"
            }
        } else {
            isError = true
            errorMessage = "You can not unlock yourself!"
        }
    }
    
    func backToHome() {
        navigation.path.removeLast(1)
    }
    
    func seeProfile() {
        navigation.path.removeLast(1)
        navigation.path.append(NavigationModel(destination: "Profile", data: data))
    }
}
