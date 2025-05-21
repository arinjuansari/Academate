//
//  AcademateProfile.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 14/05/25.
//

import SwiftUI

struct AcademateProfile: View {
    var data: AcademyMateModel
    
    var body: some View {
        VStack{
            ProfileView(data:  AcademyMateModel(id: data.id, email: data.email, name: data.name, alias: data.name, role: data.role, mentor: data.mentor, domicile: data.domicile, instagram: data.instagram, linkedin: data.linkedin, sig: data.sig))
        }
        .background(.white)
    }
}
