//
//  PlaylistDetailViewModel.swift
//  Spotify
//
//  Created by Felix Liman on 08/12/24.
//

import Foundation

final class PlaylistDetailViewModel {
    var onPlaylistUpdated: (() -> Void)?
    
    private(set) var playlist: PlaylistModel {
        didSet {
            onPlaylistUpdated?()
        }
    }
    
    init(playlist: PlaylistModel) {
        self.playlist = playlist
        onPlaylistUpdated?()
    }
    
    func addToPlaylist(_ song: SongModel) {
        guard !playlist.songs.contains(song) else { return }
        playlist.songs.append(song)
    }
}
