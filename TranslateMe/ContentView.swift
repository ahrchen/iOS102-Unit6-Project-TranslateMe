//
//  ContentView.swift
//  TranslateMe
//
//  Created by Raymond Chen on 7/31/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var translatedText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Enter word, phrase, or sentence", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button {
                    Task {
                        await fetchTranslateText()
                    }
                } label: {
                    Text("Translate")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 150)
                    Text(translatedText)
                        .font(.largeTitle)
                        .padding()
                }
                .padding()
                
                Spacer()
                
                NavigationLink(destination: TranslationView()) {
                    Text("Go to Translation View")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationTitle("Translate Me")
            .padding()
        }
        
    }
    
    func fetchTranslateText() async {
        let url = URL(string: "https://api.mymemory.translated.net/get?q=\(inputText)&langpair=en|zh-cn")!
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            
            let translationResponse = try JSONDecoder().decode(TranslationResponse.self,  from: data)
            
            let translatedText = translationResponse.responseData.translatedText
            
            self.translatedText = translatedText
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
#Preview {
    ContentView()
}
