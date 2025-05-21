//
//  CardProfile.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 10/05/25.
//

import SwiftUI

struct CardProfile: View {
    var data: CardProfileModel
    
    private var paddingTrailing: CGFloat {
#if os(iOS)
        return 8
#elseif os(watchOS)
        return 4
#endif
    }
    
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
            .background(.white)
            .cornerRadius(10)
            .frame(width: data.width, height: data.height)
            .overlay(
                VStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("Primary"))
                        .frame(width: data.pictureWidth, height: data.pictureHeight)
                        .overlay(
                            ZStack(alignment: .bottomTrailing) {
                                Image(data.name)
                                    .resizable()
                                    .frame(width: data.pictureWidth, height: data.pictureHeight)
                                    .cornerRadius(10)
#if os(iOS)
                                VStack {
                                    HStack(alignment: .center, spacing: 4) {
                                        if data.isLocked {
                                            Image(systemName: "lock.fill")
                                                .resizable()
                                                .frame(width: 10, height: 10)
                                                .foregroundColor(.white)
                                            
                                            Text("Locked")
                                                .font(.footnote)
                                                .foregroundColor(.white)
                                                .fontWeight(.semibold)
                                            
                                        } else {
                                            Image(systemName: "lock.open.fill")
                                                .resizable()
                                                .frame(width: 10, height: 10)
                                                .foregroundColor(.white)
                                            
                                            Text("Unlocked")
                                                .font(.footnote)
                                                .foregroundColor(.white)
                                                .fontWeight(.semibold)
                                        }
                                    }
                                    .padding(4)
                                    .background(Color(red: 42/255, green: 38/255, blue: 37/255).opacity(0.5))
                                    .cornerRadius(99)
                                }
                                .padding(.bottom, 8)
                                .padding(.trailing, paddingTrailing)
#endif
                            }
                            ,
                            alignment: .bottomTrailing
                        )
                    
                    Text(data.name)
                        .foregroundColor(.black)
#if os(iOS)
                        .font(.subheadline)
#elseif os(watchOS)
                        .font(.footnote)
#endif
                        .fontWeight(.medium)
                    
                    Text(data.sig)
                        .font(.footnote)
                        .foregroundColor(.black)
                        .fontWeight(.regular)
                }
                    .padding(12)
            )
            .brightness(data.isLocked ? -0.3 : 0)
    }
}
