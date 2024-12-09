//
//  PlaylistViewModel.swift
//  Spotify
//
//  Created by Felix Liman on 06/12/24.
//

import Foundation

enum PlaylistViewType {
    case grid
    case list
    
    mutating func toggle() {
        switch self {
        case .grid:
            self = .list
        case .list:
            self = .grid
        }
    }
}

final class PlaylistViewModel {
    
    var onPlaylistsUpdated: (() -> Void)?
    var onPlaylistViewTypeUpdated: (() -> Void)?
    
    private(set) var playlists: [PlaylistModel] {
        didSet {
            AppData.playlists = playlists
            onPlaylistsUpdated?()
        }
    }
    
    private(set) var playlistViewType: PlaylistViewType = .list {
        didSet {
            onPlaylistViewTypeUpdated?()
        }
    }
    
    init() {
        playlists = AppData.playlists
    }
    
    func togglePlaylistViewType() {
        playlistViewType.toggle()
    }
    
    func createNewPlaylist(title: String) {
        let id = playlists.count + 1
        let playlist = PlaylistModel(id: id, title: title, songs: [])
    
        playlists.append(playlist)
    }
    
    func updatePlaylists(_ playlist: PlaylistModel) {
        guard let playlistIndex = playlists.firstIndex(of: playlist) else { return }
        playlists[playlistIndex] = playlist
    }
}
