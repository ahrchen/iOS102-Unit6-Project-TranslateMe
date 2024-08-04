//
//  TranslationManager.swift
//  TranslateMe
//
//  Created by Raymond Chen on 8/3/24.
//

import Foundation
import FirebaseFirestore

@Observable // <-- Add the Observable macro
class TranslationManager {

    var translations: [Translation] = []
    
    private let dataBase = Firestore.firestore()

    init(isMocked: Bool = false) {
        if isMocked {
            translations = Translation.mockedTranslations
        } else {
            getTranslations()
        }
    }

    func getTranslations() {
        dataBase.collectionGroup("translations").addSnapshotListener { querySnapshot, error in
            
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            let translations = documents.compactMap { document in
                do {
                    return try document.data(as: Translation.self)
                } catch {
                    print("Error decoding document into message: \(error)")
                    return nil
                }
            }
            
            self.translations = translations.sorted(by: {$0.timestamp < $1.timestamp})
        }
    }
    
    func saveTranslation(text: String, username: String) {
        do {
            let translation = Translation(id: UUID().uuidString, text: text, timestamp: Date(), username: username)
            
            try dataBase.collection("translations").document().setData(from: translation)
            
        } catch {
            print("Error sending translation to Firestore: \(error)")
        }
    }
}

