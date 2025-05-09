//
//  DataProvider.swift
//  LiveActivities
//
//  Created by JyLooi on 09/05/2025.
//

import Observation

@Observable
public final class DataProvider: Codable, Hashable {
    var emoji: String = "🤩"
    var text: String = "Starting Live Activities"
    
    public init(emoji: String, text: String) {
        self.emoji = emoji
        self.text = text
    }
    
    // MARK: - Equatable
    public static func == (lhs: DataProvider, rhs: DataProvider) -> Bool {
        lhs.emoji == rhs.emoji &&
        lhs.text == rhs.text
    }

    // MARK: - Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(emoji)
        hasher.combine(text)
    }
}
