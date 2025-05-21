//
//  LoginScreen.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 09/05/25.
//

import Foundation
import SwiftUI
import AuthenticationServices
import DotLottie
import SwiftData

struct LoginView: View {
    @State private var viewModel: LoginViewModel
    
    init(modelContext: ModelContext, navigation: Navigation) {
        let viewModel = LoginViewModel(modelContext: modelContext, navigation: navigation)
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
            VStack {
                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: academateColors.gradient),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(height: 496)
                    .clipShape(RoundedCorner(radius: 32, corners: [.bottomLeft, .bottomRight]))
                    .overlay(
                        DotLottieAnimation(
                            webURL: "https://lottie.host/63a1d2c3-4503-4b01-a06f-623f1f0662b7/6iaAARhAwn.lottie", config: AnimationConfig(autoplay: true, loop: true)
                        ).view()
                    )
                
                Spacer()
                    .frame(height: 42)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Sign in to Academate")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    
                    Text("Connect with your academy mate to smooth sail together in your epic journey")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundColor(Color.black)
                    
                    Spacer()
                    
                    SignInWithAppleButton(.signUp) { request in
                        request.requestedScopes = [.fullName, .email]
                    } onCompletion: { result in
                        switch result {
                        case .success(let authorization):
                            viewModel.handleSuccessfulLogin(with: authorization)
                        case .failure(let error):
                            viewModel.handleLoginError(with: error)
                        }
                    }
                    .frame(height: 50)
                    .cornerRadius(99)
                    .padding()
                    
                    Spacer()
                        .frame(height: 44)
                }
                .padding(.horizontal, 20)
            }
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea(.all)
            .alert("User not found", isPresented: $viewModel.showingError) {
                Button("OK", role: .cancel) { viewModel.setError(isError: false) }
            }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
