//
//  HomeScreen.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 09/05/25.
//

import Foundation
import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var viewModel: HomeViewModel
    
    init(modelContext: ModelContext, navigation: Navigation) {
        let viewModel = HomeViewModel(modelContext: modelContext, navigation: navigation)
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("Primary"))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(viewModel.userPhoto)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                    )
                
                VStack(alignment: .leading) {
                    Text(viewModel.userName)
                        .font(.headline)
                        .fontWeight(.regular)
                    
                    Text(viewModel.userEmail)
                        .font(.footnote)
                        .fontWeight(.regular)
                }
            }
            Leaderboard(connectionCount: viewModel.userConnectionCount, data: viewModel.userLeaderboardData)
            AcademyMateCard(modelContext: viewModel.modelContext, navigation: viewModel.navigation, data: viewModel.selectedUserData)
            WatchOSCard(data: viewModel.selectedUserData)
        }
        .navigationBarBackButtonHidden(true)
        .padding()
    }
}
