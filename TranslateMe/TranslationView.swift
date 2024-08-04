//
//  TranslationView.swift
//  TranslateMe
//
//  Created by Raymond Chen on 8/3/24.
//

import SwiftUI

struct TranslationView: View {
    var body: some View {
           VStack {
               Text("This is the Translation View")
                   .font(.largeTitle)
                   .padding()

               Spacer()
           }
           .navigationTitle("Translation View")
       }
}

#Preview {
    TranslationView()
}
