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
            Button(action: {
                Task {
                    await eraseTranslationHistory()
                }
            }, label: {
                Text("Erase Translation History")
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
            })
            .navigationTitle("Translation History")
        }
   }
    func eraseTranslationHistory() async {
        translationManager.deleteTranslationHistory()
    }
}

//#Preview {
//    TranslationView()
//}
