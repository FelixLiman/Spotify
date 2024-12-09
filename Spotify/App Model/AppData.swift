//
//  AppData.swift
//  Spotify
//
//  Created by Felix Liman on 09/12/24.
//

import Foundation

struct AppData {
    static var playlists: [PlaylistModel] {
        get {
            do {
                guard let data = UserDefault.playlist.load() as? Data else { return [] }
                let playlist = try JSONDecoder().decode([PlaylistModel].self, from: data)
                return playlist
            } catch {
                return []
            }
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                UserDefault.playlist.save(value: data)
            } catch {
                print("Failed to store to User Default with error: \(error)")
            }
        }
    }
    
    static var recentSearches: [SongModel] {
        get {
            do {
                guard let data = UserDefault.recentSearches.load() as? Data else { return [] }
                let playlist = try JSONDecoder().decode([SongModel].self, from: data)
                return playlist
            } catch {
                return []
            }
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                UserDefault.recentSearches.save(value: data)
            } catch {
                print("Failed to store to User Default with error: \(error)")
            }
        }
    }
}
