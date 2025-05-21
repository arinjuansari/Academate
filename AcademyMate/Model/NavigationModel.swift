//
//  NavigationModel.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 12/05/25.
//

import Foundation
import SwiftData

@Model
class NavigationModel: Hashable {
    var destination: String
    var data: AcademyMateModel?
    
    init(destination: String, data: AcademyMateModel? = nil) {
        self.destination = destination
        self.data = data
    }
}
