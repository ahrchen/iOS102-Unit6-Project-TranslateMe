//
//  AuthManager.swift
//  TranslateMe
//
//  Created by Raymond Chen on 8/3/24.
//


import Foundation
import FirebaseAuth

@Observable
class AuthManager {
    
    var user: User?
    
    let isMocked: Bool = false
    
    var isSignedIn: Bool = false
    
    var userEmail: String? {
        
        isMocked ? "kingsley@dog.com" : user?.email
        
    }
    
    private var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.user = user
            self?.isSignedIn = user != nil
        }
    }
    
    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    
    func signUp(email: String, password: String) {
        Task {
            do {
                let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
                    self.user = authResult.user
            } catch {
                print(error)
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Task {
            do {
                let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
                self.user = authResult.user
            } catch {
                print(error)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            user = nil
        } catch {
            print(error)
        }
    }
}
