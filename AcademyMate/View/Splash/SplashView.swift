//
//  File.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 09/05/25.
//

import SwiftUI
import SwiftData

struct SplashView: View {
    @StateObject private var navigation = Navigation()
    @State private var viewModel: SplashViewModel
    
    init(modelContext: ModelContext) {
        let viewModel = SplashViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack(path: $navigation.path) {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: academateColors.gradient),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea(edges: .all)
                VStack {
                    Image("img-logo")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                        .opacity(viewModel.isShowLogo ? 1 : 0)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.0)) {
                                viewModel.showLogo()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                if self.viewModel.userData.isEmpty {
                                    self.navigation.path.append(NavigationModel(destination: "Login"))
                                } else {
                                    self.navigation.path.append(NavigationModel(destination: "Home"))
                                }
                            }
                        }
                }
                .padding()
            }
            .navigationDestination(for: NavigationModel.self) { value in
                switch value.destination {
                case "Login":
                    LoginView(modelContext: viewModel.modelContext, navigation: navigation)
                        .modelContainer(for: AcademyMateModel.self)
                case "Home":
                    HomeView(modelContext: viewModel.modelContext, navigation: navigation)
                        .modelContainer(for: AcademyMateModel.self)
                case "Success":
                    if let data = value.data {
                        SuccessView(modelContext: viewModel.modelContext, navigation: navigation, data: data)
                            .modelContainer(for: AcademyMateModel.self)
                    }
                case "Profile":
                    if let data = value.data {
                        ProfileView(data: data)
                            .modelContainer(for: AcademyMateModel.self)
                    }
                default:
                    LoginView(modelContext: viewModel.modelContext, navigation: navigation)
                        .modelContainer(for: AcademyMateModel.self)
                }
            }
        }.environment(\.navigation, navigation)
    }
}
