//
//  AcademyMateModel.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 11/05/25.
//

import Foundation
import SwiftData

@Model
class AcademyMateModel: Identifiable, Hashable {
    var id: UUID
    var email: String
    var name: String
    var alias: String
    var role: String
    var mentor: String
    var domicile: String
    var instagram: String
    var linkedin: String
    var sig: [String]
    var connections: [String]
    
    init(id: UUID, email: String, name: String, alias: String, role: String, mentor: String, domicile: String, instagram: String, linkedin: String, sig: [String], connections: [String] = []) {
        self.id = id
        self.email = email
        self.name = name
        self.alias = alias
        self.role = role
        self.mentor = mentor
        self.domicile = domicile
        self.instagram = instagram
        self.linkedin = linkedin
        self.sig = sig
        self.connections = connections
    }
}
