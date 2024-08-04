//
//  TranslateResponse.swift
//  TranslateMe
//
//  Created by Raymond Chen on 8/3/24.
//

import Foundation

struct ResponseData: Codable {
    let translatedText: String
    let match: Double
}

struct TranslationResponse: Codable {
    let responseData: ResponseData
}
