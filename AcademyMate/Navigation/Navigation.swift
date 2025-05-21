//
//  Navigation.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 12/05/25.
//

import SwiftUICore
import SwiftUI

final class Navigation: ObservableObject {
    @Published var path = NavigationPath()
}

extension EnvironmentValues {
    private struct NavigationKey: EnvironmentKey {
        static let defaultValue = Navigation()
    }

    var navigation: Navigation {
        get { self[NavigationKey.self] }
        set { self[NavigationKey.self] = newValue }
    }
}
