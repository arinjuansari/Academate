//
//  AcademyMateCardView.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 13/05/25.
//

import SwiftUI
import SwiftData

struct AcademyMateCard: View {
    @State private var viewModel: AcademyMateCardViewModel
    
    init(modelContext: ModelContext, navigation: Navigation, data: AcademyMateModel? = nil) {
        let viewModel = AcademyMateCardViewModel(modelContext: modelContext, navigation: navigation, data: data)
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(
                academateColors.stroke,
                lineWidth: 1
            )
            .frame(height: 240)
            .overlay(
                ZStack(alignment: .bottomTrailing) {
                    Image("ic-dot")
                        .cornerRadius(10)
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("Your Academy Mate")
                                .foregroundColor(.black)
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            NavigationLink(destination: AcademyMateView(modelContext: viewModel.modelContext, navigation: viewModel.navigation, data: viewModel.data)) {
                                Text("See All")
                                    .foregroundColor(academateColors.accentColor)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }
                        }
                        ScrollView(.horizontal) {
                            HStack(spacing: 12) {
                                ForEach(viewModel.filterUsers().prefix(5)) { item in
                                    let lockedProfile = !(viewModel.userConnection.contains(item.name))
                                    CardProfile(data: CardProfileModel(width: 132, height: 177, pictureWidth: 108, pictureHeight: 108, name: item.name, sig: item.sig.first ?? "-", isLocked: lockedProfile)).onTapGesture {
                                        if !lockedProfile {
                                            viewModel.lockedProfile(data: item)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(16)
                }
            )
    }
}
