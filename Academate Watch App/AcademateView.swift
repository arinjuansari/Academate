//
//  AcademyMateView.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 14/05/25.
//

import SwiftUI

struct AcademyMateView: View {
    @StateObject var userDataProvider = UserDataProvider()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var users: [AcademyMateModel] {
        let userConnection = userDataProvider.connections
        let connectedUsers = academyMateData.filter { userConnection.contains($0.name) }
        
        return connectedUsers
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if (users.isEmpty) {
                    Spacer()
                        .frame(height: 50)
                    
                    HStack(alignment: .center) {
                        Image(systemName: "lock.circle.fill")
                            .foregroundColor(.gray)
                        Text("You have not unlocked your mate yet")
                            .foregroundColor(.black)
                            .font(.system(size: 12, weight: .medium, design: .default))
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    LazyVGrid(columns: columns, spacing: 1) {
                        ForEach(users) { item in
                            NavigationLink(destination: AcademateProfile(data: item)) {
                                CardProfile(data: CardProfileModel(width: 100, height: 132, pictureWidth: 78, pictureHeight: 78, name: item.name, sig: item.sig.first ?? "", isLocked: false))
                            }
                        }
                    }
                }
            }
            .background(Color.white)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Text("Academy Mate")
                        .font(.headline)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    AcademyMateView()
}
