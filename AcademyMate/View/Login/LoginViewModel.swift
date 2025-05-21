//
//  LoginViewModel.swift
//  AcademyMate
//
//  Created by Arin Juan Sari on 12/05/25.
//

import Foundation
import SwiftData
import AuthenticationServices

@Observable
final class LoginViewModel {    
    var modelContext: ModelContext
    var navigation: Navigation
    
    var showingError = false
    
    init(modelContext: ModelContext, navigation: Navigation) {
        self.modelContext = modelContext
        self.navigation = navigation
    }
    
    func setError(isError: Bool) {
        showingError = isError
    }
    
    func handleSuccessfulLogin(with authorization: ASAuthorization) {
        if let userCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let email = userCredential.email ?? ""
            if let userData = academyMateData.first(where: { $0.email == email }) {
                modelContext.insert(userData)
                navigation.path.append(NavigationModel(destination: "Home"))
                
            } else {
                showingError = true
            }
        }
    }
    
    func handleLoginError(with error: Error) {
        print("Could not authenticate: \\(error.localizedDescription)")
    }

}
