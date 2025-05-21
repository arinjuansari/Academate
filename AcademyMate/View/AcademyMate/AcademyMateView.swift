//
//  ListAcademateScreen.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 10/05/25.
//

import SwiftUI
import SwiftData

struct AcademyMateView: View {
    @State private var viewModel: AcademyMateViewModel
    
    init(modelContext: ModelContext, navigation: Navigation, data: AcademyMateModel? = nil) {
        let viewModel = AcademyMateViewModel(modelContext: modelContext, navigation: navigation, data: data)
        _viewModel = State(initialValue: viewModel)
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            if viewModel.notFound {
                PageNotFound()
            } else {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.filteredData) { item in
                        let lockedProfile = !(viewModel.userConnection.contains(item.name))
                        CardProfile(data: CardProfileModel(width: 173, height: 227, pictureWidth: 141, pictureHeight: 141, name: item.name, sig: item.sig.first ?? "-", isLocked: lockedProfile)).onTapGesture {
                            if !lockedProfile {
                                viewModel.lockedProfile(data: item)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Academy Mate")
                    .font(.headline)
            }
        }
        .searchable(text: $viewModel.searchText, placement: .automatic, prompt: "Search your mate's name")
    }
}
