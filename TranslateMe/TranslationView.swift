//
//  TranslationView.swift
//  TranslateMe
//
//  Created by Raymond Chen on 8/3/24.
//

import SwiftUI

struct TranslationView: View {
    
    @State var translationManager: TranslationManager
    
    init(isMocked: Bool = false) {
        translationManager = TranslationManager(isMocked: isMocked)
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(translationManager.translations) { translation in
                        Text(translation.text)
                    }
                }
            }
            .navigationTitle("Translation History")
        }
           
   }
}

#Preview {
    TranslationView()
}
