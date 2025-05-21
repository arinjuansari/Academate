//
//  Leaderboard.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 10/05/25.
//

import SwiftUI

struct Leaderboard: View {
    var connectionCount: Int
    var data: LeaderboardModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(
                LinearGradient(
                    colors: academateColors.strokeGradient,
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                lineWidth: 1
            )
            .frame(height: 210)
            .overlay(
                ZStack(alignment:.topTrailing) {
                    Image("ic-logo")
                        .resizable()
                        .frame(width: 108, height: 108)
                        .colorMultiply(data.colorButton)
                        .opacity(0.5)
                        .offset(x: 50, y: -50)
                    
                    VStack {
                        HStack(spacing: 0) {
                            VStack(alignment: .leading) {
                                Text("\(connectionCount) Connects")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                
                                Text(data.title)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                
                                Text(data.personality)
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                
                                Spacer()
                                    .frame(height: 20)
                                
                                Text(data.quotes)
                                    .font(.footnote)
                                    .fontWeight(.light)
                            }
                            
                            Spacer()
                            
                            Image(data.image)
                        }
                        RoundedRectangle(cornerRadius: 10)
                            .fill(data.colorButton)
                            .frame(height: 56)
                            .overlay(
                                HStack {
                                    Text("Scan Your Mate ID Card")
                                        .foregroundColor(.white)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                    
                                    NavigationLink(destination: CameraView()){
                                        RoundedRectangle(cornerRadius: 99)
                                            .fill(.white)
                                            .frame(width: 99, height: 30)
                                            .overlay(
                                                Text("Open camera")
                                                    .foregroundColor(.black)
                                                    .font(.footnote)
                                                    .fontWeight(.semibold)
                                            )
                                    }
                                }
                                    .padding(.horizontal, 16)
                            )
                    }
                    .padding(16)
                }
                    .cornerRadius(10)
                    .clipped()
            )
    }
}

