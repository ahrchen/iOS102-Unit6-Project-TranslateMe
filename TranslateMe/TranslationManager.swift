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
    
    func deleteTranslationHistory() {
        let collectionRef = dataBase.collection("translations")
        clearCollection(collection: collectionRef)
    }
    
    func clearCollection(collection: CollectionReference, batchSize: Int = 100) {
        collection.limit(to: batchSize).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            let batch = collection.firestore.batch()
            snapshot.documents.forEach { batch.deleteDocument($0.reference) }
            
            batch.commit { (batchError) in
                if let batchError = batchError {
                    print("Error deleting batch: \(batchError)")
                    return
                }
                
                if snapshot.documents.count == batchSize {
                    // More documents exist, delete the next batch
                    self.clearCollection(collection: collection, batchSize: batchSize)
                } else {
                    print("Collection successfully cleared!")
                }
            }
        }
    }

}

