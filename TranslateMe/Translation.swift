//
//  Translation.swift
//  TranslateMe
//
//  Created by Raymond Chen on 8/3/24.
//

import Foundation

struct Translation: Hashable, Identifiable, Codable {
    let id: String
    let text: String
    let timestamp: Date
    let username: String
}

extension Translation {
    static let mockedTranslations: [Translation] = [
          "你好",     // Hello
          "谢谢",     // Thank you
          "再见",     // Goodbye
          "是",       // Yes
          "不是",     // No
          "请",       // Please
          "对不起",   // Sorry
          "我爱你",   // I love you
          "早上好",   // Good morning
          "晚上好"    // Good evening
    ].enumerated().map { index, text in
        Translation(id: UUID().uuidString, text: text, timestamp: Date(), username: index % 2 == 0 ? "cleo@dog.com" : "kingsley@dog.com")
    }
}
