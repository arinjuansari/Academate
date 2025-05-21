//
//  ProfileScreen.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 10/05/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var viewModel: ProfileModelView
    
    init(data: AcademyMateModel) {
        let viewModel = ProfileModelView(data: data)
        _viewModel = State(initialValue: viewModel)
    }
    
    private var rectangleHeight: CGFloat {
#if os(iOS)
        return 166
#elseif os(watchOS)
        return 100
#endif
    }
    
    private var imageSize: CGFloat {
#if os(iOS)
        return 141
#elseif os(watchOS)
        return 90
#endif
    }
    
    private var spacerHeight: CGFloat {
#if os(iOS)
        return 60
#elseif os(watchOS)
        return 50
#endif
    }
    
    private var spacing: CGFloat {
#if os(iOS)
        return 20
#elseif os(watchOS)
        return 6
#endif
    }
    
    private var paddingTop: CGFloat {
#if os(iOS)
        return 120
#elseif os(watchOS)
        return 0
#endif
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color("Secondary"))
                .frame(height: rectangleHeight)
                .overlay(
                    VStack{
#if os(iOS)
                        Image("ic-logo")
                            .resizable()
                            .frame(width: 139, height: 139)
                            .opacity(0.5)
                            .offset(x: 175, y: -65)
#elseif os(watchOS)
                        Image("ic-logo")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .opacity(0.5)
                            .offset(x: -100, y: 10)
#endif
                    }
                )
            
            ScrollView {
                VStack(spacing: spacing) {
                    VStack {
                        Spacer()
                            .frame(height: spacerHeight)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("Primary"))
                            .frame(width: imageSize, height: imageSize)
                            .overlay(
                                Image(viewModel.data.name)
                                    .resizable()
                                    .frame(width: imageSize, height: imageSize)
                                    .cornerRadius(10)
                            )
#if os(iOS)
                        Spacer()
                            .frame(height: 12)
#endif
                        
                        Text(viewModel.data.name)
                            .foregroundColor(.black)
                            .font(.headline)
                            .fontWeight(.semibold)
#if os(iOS)
                        Spacer()
                            .frame(height: 6)
#elseif os(watchOS)
                        Spacer()
                            .frame(height: 4)
#endif
                        
                        Text("SIG \(viewModel.data.sig.first ?? "-")")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .fontWeight(.regular)
                    }
#if os(iOS)
                    CardDetail(cardHeight: 240,
                               title: "Details",
                               details: [
                                ("Alias", viewModel.data.alias),
                                ("Role", viewModel.data.role),
                                ("Mentor", viewModel.data.mentor),
                                ("Domicile", viewModel.data.domicile),
                                ("Instagram", viewModel.data.instagram),
                                ("LinkedIn", viewModel.data.linkedin)
                               ])
                    
                    CardDetail(cardHeight: 200,
                               title: "Student Interest Group",
                               sig: viewModel.data.sig)
                    
#elseif os(watchOS)
                    CardDetail(cardHeight: 150,
                               title: "Details",
                               details: [
                                ("Alias", viewModel.data.alias),
                                ("Role", viewModel.data.role),
                                ("IG", viewModel.data.instagram),
                                ("LinkedIn", viewModel.data.linkedin)
                               ])
#endif
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, paddingTop)
        .ignoresSafeArea(edges: .all)
#if os(iOS)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Mate’s Profile")
                    .font(.headline)
            }
        }
#endif
    }
}

struct CardDetail: View {
    var cardHeight: CGFloat = 0
    var title: String = ""
    var details: [(label: String, value: String)] = []
    var sig: [String] = []
    
    private var spacing: CGFloat {
#if os(iOS)
        return 8
#else
        return 2
#endif
    }
    
    private var padding: CGFloat {
#if os(iOS)
        return 20
#else
        return 6
#endif
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(
                LinearGradient(
                    colors: academateColors.strokeGradient,
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                lineWidth: 1
            )
            .frame(height: cardHeight)
            .overlay(
                VStack(alignment: .leading, spacing: spacing) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
#if os(iOS)
                    Spacer()
                        .frame(height: 4)
#elseif os(watchOS)
                    Spacer()
                        .frame(height: 2)
#endif
                    
                    ForEach(details, id: \.label) { item in
                        DetailRow(label: item.label, value: item.value)
                    }
                    
                    SIGRow(items: sig)
                }
                    .foregroundColor(.black)
                    .padding(padding),
                alignment: .topLeading
            )
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    
    private var labelWidth: CGFloat {
#if os(iOS)
        return 80
#elseif os(watchOS)
        return 50
#else
        return 70
#endif
    }
    
    private var spacerWidth: CGFloat {
#if os(iOS)
        return 46
#else
        return 0
#endif
    }
    
    var body: some View {
        HStack(alignment: .top) {
#if os(iOS)
            Text(label)
                .frame(width: labelWidth, alignment: .leading)
#elseif os(watchOS)
            if label != "LinkedIn" {
                Text(label)
                    .frame(width: labelWidth, alignment: .leading)
            }
#endif
            if spacerWidth > 0 {
                Spacer()
                    .frame(width: spacerWidth)
            }
            
            if label == "LinkedIn" {
                if let url = URL(string: value) {
                    Link(destination: url) {
                        Text(": \(value)")
#if os(iOS)
                            .foregroundColor(Color("Primary"))
#elseif os(watchOS)
                            .foregroundColor(Color("Secondary"))
#endif
                            .underline()
                    }
                }
            } else {
                Text(": \(value)")
                    .multilineTextAlignment(.leading)
            }
        }
        .font(.body)
    }
}

struct SIGRow: View {
    let items: [String]
    let columns = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(0..<items.count, id: \.self) { index in
                Text(items[index])
                    .font(.body)
            }
        }
    }
}
