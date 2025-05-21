//
//  SuccessView.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 12/05/25.
//

import SwiftUI
import DotLottie
import SwiftData

struct SuccessView: View {
    @State private var viewModel: SuccessViewModel
    @StateObject var userDataProvider = UserDataProvider()
    
    init(modelContext: ModelContext, navigation: Navigation, data: AcademyMateModel) {
        let viewModel = SuccessViewModel(modelContext: modelContext, navigation: navigation, data: data)
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            if viewModel.isError {
                VStack {
                    Text(viewModel.errorMessage)
                        .font(.system(size: 30, weight: .semibold, design: .default))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        viewModel.backToHome()
                    }) {
                        Text("Back to Home")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(.white)
                    .foregroundColor(Color("Primary"))
                    .cornerRadius(99)
                }
                .navigationBarBackButtonHidden(true)
                .padding()
            } else {
                VStack {
                    Spacer()
                    
                    Text("Congratulations!")
                        .font(.system(size: 30, weight: .semibold, design: .default))
                        .foregroundColor(.black)
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Text("You are now connected to \(viewModel.data.name)")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 20, weight: .regular, design: .default))
                        .foregroundColor(.black)
                    
                    DotLottieAnimation(
                        webURL: "https://lottie.host/eb43b56a-f4cb-442f-b67c-8dae90a0ad69/qgT3Ju0cry.lottie",
                        config: AnimationConfig(autoplay: true, loop: true)
                    ).view()
                    
                    Button(action: {
                        userDataProvider.sendUserData(connections: viewModel.selectedUserData?.connections ?? [""])
                        
                        viewModel.seeProfile()
                    }) {
                        Text("See Profiles")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color("Primary"))
                    .foregroundColor(.white)
                    .cornerRadius(99)
                    
                    Button(action: {
                        userDataProvider.sendUserData(connections: viewModel.selectedUserData?.connections ?? [""])
                        
                        viewModel.backToHome()
                    }) {
                        Text("Back to Home")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(.white)
                    .foregroundColor(Color("Primary"))
                    .cornerRadius(99)
                }
                .navigationBarBackButtonHidden(true)
                .padding()
                
            }
        }
        .task {
            viewModel.handleError()
        }
    }
}
