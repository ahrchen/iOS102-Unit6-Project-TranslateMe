//
//  ContentView.swift
//  TranslateMe
//
//  Created by Raymond Chen on 7/31/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(AuthManager.self) var authManager
    @Environment(TranslationManager.self) var translationManager
    
    var body: some View {
        if authManager.user != nil {
            TranslateView()
                .environment(authManager)
                .environment(translationManager)
        } else {
            LoginView()
                .environment(authManager)
        }
        
    }
    
 
}

//#Preview {
//    ContentView()
//}
