//
//  TranslateMeApp.swift
//  TranslateMe
//
//  Created by Raymond Chen on 7/31/24.
//

import SwiftUI
import FirebaseCore

@main
struct TranslateMeApp: App {
    
    @State private var authManager: AuthManager
    @State private var translationManager: TranslationManager
    
    init() {
        FirebaseApp.configure()
        authManager = AuthManager()
        translationManager = TranslationManager()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authManager)
                .environment(translationManager)
        }
    }
}
