//
//  WatchOSCard.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 13/05/25.
//

import SwiftUI

struct WatchOSCard: View {
    var data: AcademyMateModel?
    @StateObject var userDataProvider = UserDataProvider()
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(
                academateColors.stroke,
                lineWidth: 1
            )
            .frame(height: 146)
            .overlay(
                ZStack(alignment: .bottomTrailing) {
                    Image("ic-dot2")
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text("Pair with Your WatchOS")
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                    .frame(height: 4)
                                
                                Text("to quickly access your mate")
                                    .foregroundColor(.black)
                                    .font(.footnote)
                                    .fontWeight(.regular)
                                
                                Text("profile in your connects")
                                    .foregroundColor(.black)
                                    .font(.footnote)
                                    .fontWeight(.regular)
                                
                                Spacer()
                                    .frame(height: 21)
                                
                                Button(action: {
                                    if let userData = data {
                                        userDataProvider.sendUserData(connections: userData.connections)
                                    }
                                }) {
                                    Text("Pair WatchOS")
                                        .foregroundStyle(.white)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                }
                                .frame(width: 100, height: 30)
                                .background(Color("Primary"))
                                .cornerRadius(99)
                            }
                            
                            Spacer()
                            
                            Image("img-pair-watchos")
                                .padding(.top, 12)
                        }
                    }
                    .padding(16)
                }
            )
    }
}
