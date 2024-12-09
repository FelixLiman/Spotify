//
//  UserDefault.swift
//  Spotify
//
//  Created by Felix Liman on 09/12/24.
//

import Foundation

enum UserDefault: String {
    case playlist = "playlist"
    case recentSearches = "recentSearches"

    func load() -> Any? {
        UserDefaults.standard.object(forKey: self.rawValue)
    }

    func save(value: Any?) {
        UserDefaults.standard.set(value, forKey: self.rawValue)
    }

    func delete() {
        UserDefaults.standard.removeObject(forKey: self.rawValue)
    }
}
