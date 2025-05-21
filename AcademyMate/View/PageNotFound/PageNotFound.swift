//
//  PageNotFound.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 16/05/25.
//
import SwiftUI

struct PageNotFound: View {
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
                .frame(height: 100)
            
            Image("img-not-found")
                .resizable()
                .frame(width: 200, height: 200)
            
            Spacer()
                .frame(height: 100)
            
            Text("No results found")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Try searching again")
                .font(.title3)
                .fontWeight(.medium)
        }
        .foregroundColor(.gray)
    }
}

#Preview {
    PageNotFound()
}
