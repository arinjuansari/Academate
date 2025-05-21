//
//  ProfileModelView.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 13/05/25.
//

import Foundation

@Observable
final class ProfileModelView {
    var data: AcademyMateModel
    
    init(data: AcademyMateModel) {
        self.data = data
    }
}
